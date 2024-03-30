import Foundation
import Alamofire
import SwiftUI

final class UserViewModel: ObservableObject {
    @AppStorage("isUserAuthenticated") var isUserAuthenticated: Bool = false
    @Published var errorMessage: String?
    @Published var isRegistered = false
    @Published var user : User!
    @Published var isLoading = true
    
    func register(firstName: String, lastName: String, email: String, password: String) {
        let registrationData = RegistrationData(firstName: firstName, lastName: lastName, email: email, password: password)
        NetworkService.shared.registerUser(registrationData: registrationData, to: "https://localhost:8081/api/auth/register") { result in
            switch result {
            case .success:
                self.isRegistered = true
                print("Регистрация успешно завершена. Токен сохранен.")
            case .failure(let error):
                print("Ошибка регистрации: \(error.localizedDescription)")
            }
        }
    }
    
    func login(email: String, password: String) {
        let loginData = LoginData(email: email, password: password)
        let urlString = "https://localhost:8081/api/auth/login"
        
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
        let urlString = "https://localhost:8081/api/user"
        let token = KeychainManager().getUserToken()!
        
        NetworkService.shared.fetchData(from: urlString, token: token) { [weak self] (result: Result<User?, Error>) in
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
    
    func resetPassword(newPassword: String) {
        let urlString = "https://localhost:8081/api/reset-password"
        let token = KeychainManager().getUserToken()!
        let parameters = ["newPassword": newPassword]
        
        NetworkService.shared.patchData(to: urlString, token: token, parameters: parameters) { result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self.isLoading = false
                case .failure(let error):
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
