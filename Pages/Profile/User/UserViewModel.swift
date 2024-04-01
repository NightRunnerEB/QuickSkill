import Foundation
import Alamofire
import SwiftUI

final class UserViewModel: ObservableObject {
    @AppStorage("isUserAuthenticated") var isUserAuthenticated: Bool = false
    @Published var errorMessage: String?
    @Published var isRegistered = false
    //    @Published var user : User!
    @Published var user : User = User(
        firstName: "John",
        lastName: "Doe",
        username: "johndoe123",
        xp: 1200,
        userLevel: 5,
        streak: 10,
        description: "Passionate learner and coder.",
        email: "john.doe@example.com",
        photo: "ДорохиеДрузья",
        energy: 5,
        crystals: 2000,
        streakSavers: 5,
        streakRecord: 12,
        followers: 10,
        followings: 15,
        goalText: "Code daily",
        goalDay: 30,
        status: "Active"
    )
    @Published var isLoading = false
    
    func register(firstName: String, lastName: String, email: String, password: String) {
        let registrationData = RegistrationData(firstName: firstName, lastName: lastName, email: email, password: password)
        let urlString = "https://localhost:8081/api/auth/register"
        
        NetworkService.shared.registerUser(registrationData: registrationData, to: urlString) { result in
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
        isLoading = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
//            self.isUserAuthenticated = true
//            isLoading = false
//        }
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
        isLoading = true
        let urlString = "https://localhost:8081/api/user"
        
//        NetworkService.shared.performRequest(to: urlString, method: .get) { [weak self] (result: Result<User?, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let dataModel):
//                    self?.user = dataModel!
//                    self?.isLoading = false
//                case .failure(let error):
//                    self?.handleError(error)
//                }
//            }
//        }
    }
    
    func addResults(xp: Int, crystals: Int) {
        self.user.xp += xp
        self.user.crystals += crystals
    }
    
    func resetPassword(newPassword: String) {
        let urlString = "https://localhost:8081/api/reset-password"
        let parameters = ["newPassword": newPassword]
        
        NetworkService.shared.performRequest(to: urlString, method: .patch , parameters: parameters) { (result: Result<EmptyResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success:
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
