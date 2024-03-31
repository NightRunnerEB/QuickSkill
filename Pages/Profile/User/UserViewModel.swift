import Foundation
import Alamofire
import Combine
import SwiftUI

final class UserViewModel: ObservableObject {
    @AppStorage("isUserAuthenticated") var isUserAuthenticated: Bool = false
    @Published var isRegistered = false
    @Published var isLoading = false
    var cancellables = Set<AnyCancellable>()
    
    @Published var user : User
    
    // Для тестов
    init() {
        user = User(email: "vipkiller.b@mail.ru", firstName: "Evgeniy", lastName: "Bukharev", password: "123456789", avatarImageUrl: "ДорохиеДрузья", bio: "Qwerty")
        user.ratingLeague = Array(repeating: User(email: "vipkiller.b@mail.ru", firstName: "Evgeniy", lastName: "Bukharev", password: "123456789", avatarImageUrl: "ДорохиеДрузья", bio: "Qwerty"), count: 20)
        
        user.following = Array(repeating: User(email: "vipkiller.b@mail.ru", firstName: "Alexey", lastName: "Kiselev", password: "123456789", avatarImageUrl: "ДорохиеДрузья", bio: "Qwerty"), count: 3)
    }
    
    func register(firstName: String, lastName: String, email: String, password: String) {
        self.isRegistered = true
//        let registrationData = RegistrationData(firstName: firstName, lastName: lastName, email: email, password: password)
//        NetworkServiceWithAlamofire.shared.registerUser(registrationData: registrationData, to: "https://localhost:8081/api/auth/register") { result in
//            switch result {
//            case .success:
//                self.isRegistered = true
//                print("Регистрация успешно завершена. Токен сохранен.")
//            case .failure(let error):
//                print("Ошибка регистрации: \(error.localizedDescription)")
//            }
//        }
    }
    
    func login(email: String, password: String) {
        self.isUserAuthenticated = true         // В рамках тестрирования в период отсутствия взаимосвязи с сервером.
        let loginData = LoginData(email: email, password: password)
//        NetworkServiceWithAlamofire.shared.loginUser(loginData: loginData, to: "https://localhost:8081/api/auth/login")  { result in
//            switch result {
//            case .success:
//                self.isUserAuthenticated = true
//                print("Вход выполнен успешно. Токен сохранен.")
//            case .failure(let error):
//                print("Ошибка входа: \(error.localizedDescription)")
//            }
//        }
    }
}
