//
//  DailyTaskViewModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.03.2024.
//

import SwiftUI
import Foundation

final class DailyTaskViewModel: ObservableObject {
    @Published var errorMessage: String!
    @Published var isLoading = false
    @Published var tasks : [DailyTask] = []
    
    func getTasks() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            tasks = DailyTask.sampleData
            self.isLoading = false
        }
//        let urlString = "https://localhost:8081/api/course"
//        
//        NetworkService.shared.performRequest(to: urlString, method: .get) { [weak self] (result: Result<[DailyTask]?, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let dataModel):
//                    self?.tasks = dataModel!
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

