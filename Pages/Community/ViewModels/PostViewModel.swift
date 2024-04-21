//
//  PostViewModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.03.2024.
//

import Foundation
import Alamofire

final class PostViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var answers: [Answer] = []
    @Published var post : Post!
    @Published var posts : [Post] = []
    
    func getPosts() {
        //        self.isLoading = true
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
        //            // Для тестов
        //        }
        //        self.isLoading = false
        
        let parameters: Parameters = ["page": 0, "pageSize": 3]
        let urlString = "https://localhost:443/api/social/discussion"
        
        NetworkService.shared.performGETRequest(to: urlString, parameters: parameters) { [weak self] (result: Result<[Post], Error>) in
            switch result {
            case .success(let dataModel):
                print("Успех")
                print(dataModel)
                self?.posts = dataModel
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
    
    func makePost(topic: String, description: String) {
        //        self.isLoading = true
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
        //            posts.append(Post(discussion: Discussion(id: 5, title: topic, body: description, date: "2024/04/15", likes: 0, countAnswers: 0), author: Author(id: 15, icon: "Окунь", firstName: "Seif", lastName: "Kabum")))
        //            completion()
        //            self.isLoading = false
        //        }
        
        let urlString = "https://localhost:443/api/social/discussion"
        let parameters : Parameters = ["topic": topic, "body": description, "userId": 0]
        
        NetworkService.shared.performRequest(to: urlString, method: .post, parameters: parameters) { [weak self] (result: Result<EmptyResponse, Error>) in
                switch result {
                case .success:
                    return
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


