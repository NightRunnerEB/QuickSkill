//
//  BadgeViewModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.03.2024.
//

import Foundation

final class BadgeViewModel: ObservableObject {
    @Published var errorMessage: String!
    @Published var isLoading = false
    @Published var badges : [Badge] = []
    
    init() {
        self.getBadges()
    }
    
    func getBadges() {
        self.isLoading = true
        let urlString = "https://localhost:8081/api/badges/user"
        let token = KeychainManager().getUserToken()!
        
        NetworkService.shared.fetchData(from: urlString, token: token) { [weak self] (result: Result<[Badge]?, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let dataModel):
                    self?.badges = dataModel!
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
