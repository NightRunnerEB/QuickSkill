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
    
    
    func getAnswers(discussionId: Int) {
        self.isLoading = true
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //            self.answers = AnswerWithAuthor.sampleData
        //            self.isLoading = false
        //        }
        
        let urlString = "https://localhost:8081/api/answers"
        
        NetworkService.shared.performRequest(to: urlString, method: .get) { [weak self] (result: Result<[AnswerWithAuthor], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let dataModel):
                    self?.answers = dataModel
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
    
    func makeAnswer(content: String, completion: @escaping () -> Void) {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            answers.append(AnswerWithAuthor(answer: Answer(id: 10, body: content, date: "2024/04/10", likes: 0), author: Author(id: 21, icon: "ДорохиеДрузья", firstName: "Evgeniy", lastName: "Kurtov")))
            completion()
            self.isLoading = false
        }
        
        let urlString = "https://localhost:8081/api/discussion"
        let parametr = ["content": content]
        
        NetworkService.shared.performRequest(to: urlString, method: .post, parameters: parametr) { [weak self] (result: Result<EmptyResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success:
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

