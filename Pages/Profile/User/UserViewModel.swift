import Foundation
import Alamofire
import SwiftUI

final class UserViewModel: ObservableObject {
    @AppStorage("isUserAuthenticated") var isUserAuthenticated: Bool = false
    @Published var errorMessage: String?
    @Published var isRegistered = false
    @Published var user : User!
    @Published var isLoading = false
    
    func register(firstName: String, lastName: String, email: String, password: String, completion: @escaping () -> Void) {
        let registrationData = RegistrationData(firstname: firstName, lastname: lastName, email: email, password: password)
        let urlString = "https://localhost:8081/api/auth/register"
        
        NetworkService.shared.registerUser(registrationData: registrationData, to: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isRegistered = true
                    print("Регистрация успешно завершена.")
                    completion()
                case .failure(let error):
                    print("Ошибка регистрации: \(error.localizedDescription)")
                    completion()
                }
            }
        }
    }

    
    func login(email: String, password: String) {
        isLoading = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
//            self.isUserAuthenticated = true
//            isLoading = false
//        }
                let loginData = LoginData(email: email, password: password)
                let urlString = "https://localhost:443/api/auth/login"
        
                NetworkService.shared.loginUser(loginData: loginData, to: urlString)  { result in
                    switch result {
                    case .success:
                        self.isUserAuthenticated = true
                        self.isLoading = false
                        print("Вход выполнен успешно. Токен сохранен.")
                    case .failure(let error):
                        print("Ошибка входа: \(error.localizedDescription)")
                    }
                }
    }
    
    func getInfo() {
        let urlString = "https://localhost:443/api/user/current"
        
        NetworkService.shared.performGETRequest(to: urlString) { [weak self] (result: Result<User?, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let dataModel):
                    self?.user = dataModel!
                    self?.isLoading = false
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
    }
    
    func addResults(xp: Int, crystals: Int) {
        self.user.xp += xp
        self.user.crystall += crystals
    }
    
    func resetPassword(newPassword: String) {
        let urlString = "https://localhost:8081/api/reset-password"
        let parameters = ["newPassword": newPassword]
        
        NetworkService.shared.performRequest(to: urlString, method: .patch , parameters: parameters) { (result: Result<EmptyResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isLoading = false
                case .failure(_):
                    self.errorMessage = "Произошла ошибка, попробуйте позже"
                }
            }
        }
    }
    
    private func handleError(_ error: Error) {
        if let afError = error.asAFError {
            switch afError {
            case .responseValidationFailed(reason: let reason):
                switch reason {
                case .unacceptableStatusCode(code: let code):
                    // Обработка HTTP ошибок
                    switch code {
                    case 400:
                        errorMessage = "Неверный запрос. Пожалуйста, проверьте введённые данные."
                    case 401:
                        errorMessage = "Не авторизован. Возможно, истекла сессия."
                    case 403:
                        errorMessage = "Доступ запрещён."
                    case 404:
                        errorMessage = "Ресурс не найден."
                    case 500...599:
                        errorMessage = "Ошибка сервера. Попробуйте позже."
                    default:
                        errorMessage = "Ошибка \(code). Пожалуйста, попробуйте позже."
                    }
                default:
                    errorMessage = "Неверный формат ответа."
                }
            case .sessionTaskFailed(error: let sessionError):
                if (sessionError as NSError).code == NSURLErrorTimedOut {
                    errorMessage = "Медленная скорость интернета!"
                } else {
                    errorMessage = "Проблема сетевого соединения."
                }
            default:
                errorMessage = "Произошла ошибка: \(error.localizedDescription)"
            }
        } else {
            errorMessage = "Неизвестная ошибка: \(error.localizedDescription)"
        }
    }
    
}
