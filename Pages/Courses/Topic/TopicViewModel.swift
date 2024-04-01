//
//  TopicViewModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.03.2024.
//

import Foundation
import Alamofire

final class TopicViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var topics: [Topic] = []
    
    // Возможно стоит переделать на Combine
    func getTopics(courseId: Int) {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.topics = Topic.topics
        }
        self.isLoading = false
        
//        let urlString = "https://localhost:8081/api/course"
//        let parametr = ["courseId": courseId]
//        
//        NetworkService.shared.performRequest(to: urlString, method: .get, parameters: parametr) { [weak self] (result: Result<[Topic]?, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let dataModel):
//                    self?.topics = dataModel!
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
