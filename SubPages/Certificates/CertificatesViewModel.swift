//
//  CertificatesViewModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.03.2024.
//

import SwiftUI
import Foundation

final class СertificateViewModel: ObservableObject {
    @Published var errorMessage: String!
    @Published var isLoading = false
    @Published var certificates: [Certificate]?
    
    func getCertificates() {
        self.isLoading = true
        let urlString = "https://localhost:8081/api/course"
        let token = KeychainManager().getUserToken()!
        
        NetworkService.shared.fetchData(from: urlString, token: token) { [weak self] (result: Result<[Certificate]?, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let dataModel):
                    self?.certificates = dataModel!
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

