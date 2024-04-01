//
//  CourseViewModel.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.03.2024.
//

import Foundation
import Alamofire

final class CourseViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var topics: [Topic] = []
    @Published var course : Course!
    @Published var allCourses : [Course] = []
    @Published var userCourses : [Course] = []
    
    init() {
        self.getUserCourses()
    }
    
    // Возможно стоит переделать на Combine
    func getCourse(courseId: Int) {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            course = Course.courses[courseId]
            self.isLoading = false
            
            //            let urlString = "https://localhost:8081/api/course"
            //            let parametr = ["courseId": courseId]
            //            NetworkService.shared.performRequest(to: urlString, method: .get , parameters: parametr) { [weak self] (result: Result<Course?, Error>) in
            //                        DispatchQueue.main.async {
            //                            switch result {
            //                            case .success(let dataModel):
            //                                self?.course = dataModel!
            //                                self?.isLoading = false
            //                            case .failure(let error):
            //                                if let afError = error.asAFError, let underlyingError = afError.underlyingError as NSError?, underlyingError.domain == NSURLErrorDomain, underlyingError.code == NSURLErrorTimedOut {
            //                                    // Ошибка тайм-аута
            //                                    self?.errorMessage = "Медленная скорость интернета!"
            //                                } else {
            //                                    // Другие ошибки
            //                                    self?.errorMessage = "Ошибка при выполнении запроса: \(error.localizedDescription)"
            //                                }
            //                            }
            //                        }
            //                    }
        }
    }
    
    func getCourses() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            allCourses = Course.courses
            self.isLoading = false
            
            //            let urlString = "https://localhost:8081/api/course"
            //
            //            NetworkService.shared.performRequest(to: urlString, method: .get) { [weak self] (result: Result<[Course]?, Error>) in
            //                DispatchQueue.main.async {
            //                    switch result {
            //                    case .success(let dataModel):
            //                        self?.allCourses = dataModel!
            //                        self?.isLoading = false
            //                    case .failure(let error):
            //                        if let afError = error.asAFError, let underlyingError = afError.underlyingError as NSError?, underlyingError.domain == NSURLErrorDomain, underlyingError.code == NSURLErrorTimedOut {
            //                            // Ошибка тайм-аута
            //                            self?.errorMessage = "Медленная скорость интернета!"
            //                        } else {
            //                            // Другие ошибки
            //                            self?.errorMessage = "Ошибка при выполнении запроса: \(error.localizedDescription)"
            //                        }
            //                    }
            //                }
            //            }
        }
    }
    
    func getUserCourses() {
        self.isLoading = true
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            userCourses = [Course.courses[0], Course.courses[2]]
            self.isLoading = false
        }
        
        //        NetworkService.shared.performRequest(to: urlString, method: .get) { [weak self] (result: Result<[Course]?, Error>) in
        //            DispatchQueue.main.async {
        //                switch result {
        //                case .success(let dataModel):
        //                    self?.userCourses = dataModel!
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
    
    func getFilteredCourses(name: String, difficult: Int?, duration: Int?, free: Bool?) {
        self.isLoading = true
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            allCourses = Course.courses
            self.isLoading = false
        }
        
//        let urlString = "https://localhost:8081/api/filtered_courses"
//        
//        NetworkService.shared.performRequest(to: urlString, method: .get) { [weak self] (result: Result<[Course]?, Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let dataModel):
//                    self?.allCourses = dataModel!
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
