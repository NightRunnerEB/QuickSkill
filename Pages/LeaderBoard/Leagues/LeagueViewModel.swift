//
//  LeagueViewModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.03.2024.
//

import Foundation

final class LeagueViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var users: [User] = []
    @Published var followings: [User]!
    
    func getLeague() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            for i in 0..<20 {
                let user = User(
                    firstName: i < 10 ? "John" : "Anonymous",
                    lastName: i < 10 ? "Doe\(i)" : "",
                    username: i < 10 ? "johndoe123\(i)" : "anonymous",
                    xp: i < 10 ? 1200 : 0,
                    userlevel: i < 10 ? 5 : 0,
                    streak: i < 10 ? 10 : 0,
                    maxStreak: i < 10 ? 12 : 0,
                    description: i < 10 ? "Passionate learner and coder." : "",
                    photo: i < 10 ? "ДорохиеДрузья" : "AnonymousPhoto",
                    goalText: i < 10 ? "Code daily" : "",
                    goalDay: i < 10 ? 30 : 0,
                    status: i < 10 ? "Active" : "Inactive",
                    freezer: i < 10 ? 5 : 0,
                    hearts: i < 10 ? 100 : 0,
                    crystall: i < 10 ? 50 : 0
                )
                users.append(user)
            }
            self.isLoading = false
        }
        
//        let urlString = "https://localhost:8081/api/badges/user"
//        let parametr = ["courseId": courseId]
//        
//        NetworkService.shared.performRequest(to: urlString, method: .get, parameters: parametr) { [weak self] (result: Result<[User]?, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let dataModel):
//                    self?.users = dataModel!
//                    self?.isLoading = false
//                case .failure(let error):
//                    if let afError = error.asAFError, let underlyingError = afError.underlyingError as NSError?, underlyingError.domain == NSURLErrorDomain, underlyingError.code == NSURLErrorTimedOut {
//                        // Ошибка тайм-аута
//                        self?.errorMessage = "Медленная скорость интернета!"
//                    } else {
//                        // Другие ошибки
//                        self?.errorMessage = "Ошибка при выполнении запроса: \(error.localizedDescription)"
//                    }
//                }
//            }
//        }
    }
    
    func getFollowings() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            followings = Array(repeating: User(
                firstName: "Alexey",
                lastName: "Kiselev",
                username: "johndoe123",
                xp: 1200,
                userlevel: 5,
                streak: 10,
                maxStreak: 12, description: "Passionate learner and coder.",
                photo: "ДорохиеДрузья",
                goalText: "Code daily",
                goalDay: 30,
                status: "Active",
                freezer: 5,
                hearts: 100,
                crystall: 50
            ), count: 5)
            self.isLoading = false
        }
        
//        let urlString = "https://localhost:8081/api/league/followings"
//        
//        NetworkService.shared.performRequest(to: urlString, method: .get) { [weak self] (result: Result<[User]?, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let dataModel):
//                    self?.followings = dataModel!
//                    self?.isLoading = false
//                case .failure(let error):
//                    if let afError = error.asAFError, let underlyingError = afError.underlyingError as NSError?, underlyingError.domain == NSURLErrorDomain, underlyingError.code == NSURLErrorTimedOut {
//                        // Ошибка тайм-аута
//                        self?.errorMessage = "Медленная скорость интернета!"
//                    } else {
//                        // Другие ошибки
//                        self?.errorMessage = "Ошибка при выполнении запроса: \(error.localizedDescription)"
//                    }
//                }
//            }
//        }
    }
}
