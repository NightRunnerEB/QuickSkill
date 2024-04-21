//
//  PracticeViewModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.03.2024.
//

import Foundation

// ViewModel для вопроса
class QuizViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var quizCompleted = false
    @Published var questions: [Question]?
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswer: Int?
    @Published var isAnswered = false    
    var success = 0
    var score = 0
    var crystals = 0
    
    func loadQuestions(courseId: Int) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            questions = [
                Question(id: 0, text: "Which programming language is boring to anyone?", answers: ["C", "C++", "C#", "C--"], correctAnswer: 2),
                Question(id: 1, text: "Which programming language is not boring to anyone", answers: ["Swift", "C#", "PHP", "Go"], correctAnswer: 0),
                Question(id: 3, text: "String is ...", answers: ["Int", "char", "*char", "52"], correctAnswer: 2),
                Question(id: 4, text: "Which framework is the best?", answers: ["ASP.NET", "SwiftUI", "Django", "Angular"], correctAnswer: 1)
            ]
        }
        isLoading = false
        
//        let urlString = "https://localhost:8081/api/discussion"
//        let parametr = ["courseId": courseId]
//        
//        NetworkService.shared.performRequest(to: urlString, method: .get, parameters: parametr) { [weak self] (result: Result<[Question], Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let models):
//                    self?.questions = models
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
    
    // Метод для проверки ответа и перехода к следующему вопросу
    func checkAnswer()-> Bool {
        isAnswered = true
        if isCurrentAnswerCorrect() {
            score += 100
            crystals += 30
            success += 1
            return true
        } else {
            return false
        }
    }
    
    // Метод для проверки, правильный ли текущий ответ
    func isCurrentAnswerCorrect() -> Bool {
        guard currentQuestionIndex < questions!.count else { return false }
        return questions![currentQuestionIndex].isAnswerCorrect(selectedAnswer!)
    }
    
    // Метод для перехода к следующему вопросу
    func goToNextQuestion() {
        if currentQuestionIndex + 1 < questions!.count {
            currentQuestionIndex += 1
            selectedAnswer = nil // Сброс выбранного ответа
            isAnswered = false
        }
    }
    
    func getCurrentQuestion() -> Question? {
        return questions?[currentQuestionIndex]
    }
}
