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
    @Published var users: [User]!
    @Published var followings: [User]!
    
    // Возможно стоит переделать на Combine, но как будто нет
    func getLeague(courseId: Int) {
        self.isLoading = true
        let urlString = "https://localhost:8081/api/badges/user"
        let token = KeychainManager().getUserToken()!
        let parametr = ["courseId": courseId]
        
        NetworkService.shared.fetchData(from: urlString, parameters: parametr, token: token) { [weak self] (result: Result<[User]?, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let dataModel):
                    self?.users = dataModel!
                    self?.isLoading = false
                case .failure(let error):
                    if let afError = error.asAFError, let underlyingError = afError.underlyingError as NSError?, underlyingError.domain == NSURLErrorDomain, underlyingError.code == NSURLErrorTimedOut {
                        // Ошибка тайм-аута
                        self?.errorMessage = "Медленная скорость интернета!"
                    } else {
                        // Другие ошибки
                        self?.errorMessage = "Ошибка при выполнении запроса: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
    
    func getFollowings(courseId: Int) {
        self.isLoading = true
        let urlString = "https://localhost:8081/api/league/followings"
        let token = KeychainManager().getUserToken()!
        let parametr = ["courseId": courseId]
        
        NetworkService.shared.fetchData(from: urlString, parameters: parametr, token: token) { [weak self] (result: Result<[User]?, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let dataModel):
                    self?.followings = dataModel!
                    self?.isLoading = false
                case .failure(let error):
                    if let afError = error.asAFError, let underlyingError = afError.underlyingError as NSError?, underlyingError.domain == NSURLErrorDomain, underlyingError.code == NSURLErrorTimedOut {
                        // Ошибка тайм-аута
                        self?.errorMessage = "Медленная скорость интернета!"
                    } else {
                        // Другие ошибки
                        self?.errorMessage = "Ошибка при выполнении запроса: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
}
