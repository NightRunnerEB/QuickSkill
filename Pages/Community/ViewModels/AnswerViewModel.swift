//
//  AnswerViewModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.03.2024.
//

import Foundation
import Alamofire

final class AnswerViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var answers: [AnswerWithAuthor] = []
    
    
    func getAnswers(discussionId: Int, page: Int, pageSize: Int) {
        //        self.isLoading = true
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //            self.answers = AnswerWithAuthor.sampleData
        //            self.isLoading = false
        //        }
        
        let parameters: Parameters = ["page": 0, "pageSize": 5]
        let urlString = "https://localhost:443/api/social/answer/discussion/\(discussionId)"
        
        NetworkService.shared.performGETRequest(to: urlString, parameters: parameters) { [weak self] (result: Result<[AnswerWithAuthor], Error>) in
            switch result {
            case .success(let dataModel):
                self?.answers = dataModel
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
    
    func makeAnswer(discussionId: Int, body: String) {
        //        self.isLoading = true
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
        //            answers.append(AnswerWithAuthor(answer: Answer(id: 10, body: content, date: "2024/04/10", likes: 0), author: Author(id: 21, photo: "ДорохиеДрузья", firstName: "Evgeniy", lastName: "Kurtov")))
        //            completion()
        //            self.isLoading = false
        //        }
        
        let urlString = "https://localhost:443/api/social/answer"
        let parameters: Parameters = ["discussionId": discussionId, "userId": 0, "body": body]
        
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

