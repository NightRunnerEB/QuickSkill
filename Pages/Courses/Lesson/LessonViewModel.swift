//
//  LessonViewModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.03.2024.
//

import Foundation

final class LectureViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var transcript = ""
    @Published var notes = ""
    
    func getTranscript(lessonId: Int) {
        self.isLoading = true
        transcript = "No writer who knows the great writers who did not receive the Prize can accept it other than with humility. There is no need to list these writers. Everyone here may make his own list according to his knowledge and his conscience.\nIt would be impossible for me to ask the Ambassador of my country to read a speech in which a writer said all of the things which are in his heart. Things may not be "
        self.isLoading = false
        
        let urlString = "https://localhost:8081/api/transcript"
        
        NetworkService.shared.performRequest(to: urlString, method: .get) { [weak self] (result: Result<String, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let dataModel):
                    self?.transcript = dataModel
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
    
    func getNotes(lessonId: Int) {
        self.isLoading = true
        notes = "No writer who knows the great writers who did not receive the Prize can accept it other than with humility. There is no need to list these writers. Everyone here may make his own list according to his knowledge and his conscience.\nIt would be impossible for me to ask the Ambassador of my country to read a speech in which a writer said all of the things which are in his heart. Things may not be "
        self.isLoading = false
        
//        let urlString = "https://localhost:8081/api/notes"
//        
//        NetworkService.shared.performRequest(to: urlString, method: .get) { [weak self] (result: Result<String, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let dataModel):
//                    self?.notes = dataModel
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


