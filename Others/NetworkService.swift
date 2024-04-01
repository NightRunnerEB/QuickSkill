//
//  NetworkService.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 27.03.2024.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    // Ленивая инициализация для 'session', чтобы использовать 'manager'
    private lazy var session: Session = {
        let manager = ServerTrustManager(evaluators: ["localhost": DisabledTrustEvaluator()])
        return Session(serverTrustManager: manager)
    }()
    
    private init() { }
    
    //    func fetchData<T: Decodable>(from urlString: String, parameters: Parameters? = nil, token: String, completion: @escaping (Result<T?, Error>) -> Void) {
    //        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
    //        guard var urlComponents = URLComponents(string: encodedUrlString) else {
    //            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
    //            return
    //        }
    //
    //        // Добавление параметров к URL, если они предоставлены
    //        if let parameters = parameters, !parameters.isEmpty {
    //            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    //        }
    //
    //        guard let url = urlComponents.url else {
    //            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
    //            return
    //        }
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "GET"
    //        request.timeoutInterval = 10
    //
    //        // Установка заголовков
    //            let headers = HTTPHeaders([
    //                "Authorization": "Bearer \(token)",
    //                "Content-Type": "application/json"
    //            ])
    //        request.headers = headers
    //
    //        // Выполняем запрос
    //        AF.request(request)
    //            .validate(statusCode: 200..<300)
    //            .responseDecodable(of: T?.self) { response in
    //                switch response.result {
    //                case .success(let value):
    //                    completion(.success(value))
    //                case .failure(let error):
    //                    if (error.asAFError?.underlyingError as NSError?)?.code == NSURLErrorTimedOut {
    //                        // Упрощённая обработка ошибки тайм-аута
    //                        completion(.failure(NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: [NSLocalizedDescriptionKey: "Медленная работа интернета!"])))
    //                    } else {
    //                        completion(.failure(error))
    //                    }
    //                }
    //            }
    //    }
    //
    //    func postData<T: Decodable>(to urlString: String, token: String, parameters: Parameters, completion: @escaping (Result<T, Error>) -> Void) {
    //
    //        guard let url = URL(string: urlString) else {
    //            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
    //            return
    //        }
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //        request.timeoutInterval = 10
    //
    //        // Настраиваем заголовки запроса
    //        let headers = HTTPHeaders([
    //            "Authorization": "Bearer \(token)",
    //            "Content-Type": "application/json"
    //        ])
    //        request.headers = headers
    //
    //        // Добавляем параметры в тело запроса
    //        do {
    //            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
    //        } catch {
    //            completion(.failure(error))
    //            return
    //        }
    //
    //        // Выполняем запрос
    //        AF.request(request)
    //            .validate(statusCode: 200..<300) // Проверяем, что статус-код ответа находится в допустимом диапазоне
    //            .responseDecodable(of: T.self) { response in
    //                switch response.result {
    //                case .success(let value):
    //                    completion(.success(value))
    //                case .failure(let error):
    //                    if (error.asAFError?.underlyingError as NSError?)?.code == NSURLErrorTimedOut {
    //                        // Упрощённая обработка ошибки тайм-аута
    //                        completion(.failure(NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: [NSLocalizedDescriptionKey: "Медленная работа интернета!"])))
    //                    } else {
    //                        completion(.failure(error))
    //                    }
    //                }
    //            }
    //    }
    //
    //    func patchData(to urlString: String, token: String, parameters: Parameters, completion: @escaping (Result<Void, Error>) -> Void) {
    //
    //        guard let url = URL(string: urlString) else {
    //            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
    //            return
    //        }
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "PATCH"
    //        request.timeoutInterval = 10
    //
    //        // Настраиваем заголовки запроса
    //        let headers = HTTPHeaders([
    //            "Authorization": "Bearer \(token)",
    //            "Content-Type": "application/json"
    //        ])
    //        request.headers = headers
    //
    //        do {
    //            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
    //        } catch {
    //            completion(.failure(error))
    //            return
    //        }
    //
    //        // Выполняем запрос
    //        AF.request(request)
    //            .validate(statusCode: 200..<300) // Проверяем, что статус-код ответа находится в допустимом диапазоне
    //            .response { response in
    //                switch response.result {
    //                case .success(_):
    //                    completion(.success(()))
    //                case .failure(let error):
    //                    if (error.asAFError?.isSessionTaskError == true) && ((error.asAFError?.underlyingError as NSError?)?.code == NSURLErrorTimedOut) {
    //                        // Обработка ошибки тайм-аута
    //                        completion(.failure(NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: [NSLocalizedDescriptionKey: "Медленная работа интернета!"])))
    //                    } else {
    //                        completion(.failure(error)) // В случае другой ошибки возвращаем её
    //                    }
    //                }
    //            }
    //    }
    
    // Функция для обновления токена
    func refreshToken(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = KeychainManager.shared.getRefreshToken(), let token = KeychainManager.shared.getUserToken() else {
            completion(false)
            return
        }
        
        let urlString = "https://localhost:8081/api/auth/refresh"
        let parameters: Parameters = ["accessToken": token, "refreshToken": refreshToken]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let authResponse):
                    // Сохраняем новый access token и refresh token
                    KeychainManager.shared.saveUserToken(authResponse.accessToken)
                    KeychainManager.shared.saveRefreshToken(authResponse.refreshToken)
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
    }
    
    // Функция для отправки запроса с обработкой возможности обновления токена
    func performRequest<T: Decodable>(to urlString: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Неверный URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 10 // Установка интервала времени ожидания

        // Устанавливаем Cookie с токеном
        if let token = KeychainManager.shared.getUserToken() {
            request.setValue("auth_token=\(token)", forHTTPHeaderField: "Cookie")
        } else {
            let error = NSError(domain: "com.mydomain.app", code: 401, userInfo: [NSLocalizedDescriptionKey: "Authentication token not found. Please login again."])
            completion(.failure(error))
        }
        
        // Установка заголовков
        var updatedHeaders = HTTPHeaders()
        if let headers = headers {
            updatedHeaders = headers
        }
        updatedHeaders.add(name: "Content-Type", value: "application/json")
        request.headers = updatedHeaders

        // Кодирование параметров, если они есть
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        // Выполнение запроса с использованием Alamofire
        AF.request(request)
            .validate(statusCode: 200..<300)
            .response { response in
                   switch response.result {
                   case .success(_):
                       if T.self == EmptyResponse.self {
                           // Приводим к типу T и отправляем пустой ответ, если ожидается пустой ответ
                           completion(.success(EmptyResponse() as! T))
                       } else {
                           // Пытаемся декодировать, если ожидается содержимое
                           guard let data = response.data, !data.isEmpty else {
                               completion(.failure(NSError(domain: "EmptyResponse", code: 0, userInfo: nil)))
                               return
                           }
                           do {
                               let value = try JSONDecoder().decode(T.self, from: data)
                               completion(.success(value))
                           } catch {
                               completion(.failure(error))
                           }
                       }
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else {
                        completion(.failure(NSError(domain: "UnknownError", code: 0, userInfo: nil)))
                        return
                    }
                    
                    if statusCode == 401 {
                        // Токен истек, нужно обновить
                        self.refreshToken { success in
                            if success {
                                // Обновляем токен и повторяем запрос
                                self.performRequest(to: urlString, method: method, parameters: parameters, headers: headers, completion: completion)
                            } else {
                                completion(.failure(error))
                            }
                        }
                    } else if (error.asAFError?.isSessionTaskError == true) && (error as NSError).code == NSURLErrorTimedOut {
                        completion(.failure(NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }
    
    
    
    
    func registerUser(registrationData: RegistrationData, to urlString: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(registrationData)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        // Выполняем запрос с использованием Alamofire
        session.request(request).response { response in
            guard let statusCode = response.response?.statusCode else {
                print("300")
                completion(.failure(NSError(domain: "NoResponse", code: 0, userInfo: [NSLocalizedDescriptionKey: "Ответ от сервера не получен."])))
                return
            }
            
            switch statusCode {
            case 200:
                // Запрос успешно обработан
                completion(.success(()))
            case 400:
                // Неправильное тело запроса
                completion(.failure(NSError(domain: "BadRequest", code: 400, userInfo: [NSLocalizedDescriptionKey: "Неправильное тело запроса."])))
            case 409:
                // Ошибка на сервере
                completion(.failure(NSError(domain: "ServerError", code: 409, userInfo: [NSLocalizedDescriptionKey: "Пользователь с такой почтой уже существует."])))
            default:
                // Обработка других кодов состояния
                completion(.failure(NSError(domain: "UnexpectedResponse", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Неожиданный ответ от сервера с кодом \(statusCode)."])))
                
            }
        }
    }
    
    func loginUser(loginData: LoginData, to urlString: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(loginData)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        // Выполняем запрос с использованием Alamofire
        session.request(request).response { response in
            switch response.result {
            case .success:
                guard let httpResponse = response.response else {
                    completion(.failure(NSError(domain: "NoResponse", code: 0, userInfo: nil)))
                    return
                }
                
                // Извлекаем cookies из заголовков ответа
                if let headerFields = httpResponse.allHeaderFields as? [String: String], let url = httpResponse.url {
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
                    
                    // Ищем нужный cookie
                    if let userTokenCookie = cookies.first {
                        // Сохраняем значение токена в Keychain
                        print("Найден токен: \(userTokenCookie.value)")
                        KeychainManager.shared.saveUserToken(userTokenCookie.value)
                        completion(.success(()))
                    } else {
                        // Ошибка: cookie с токеном не найден
                        completion(.failure(NSError(domain: "TokenError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Токен пользователя не найден в cookies."])))
                    }
                } else {
                    // Ошибка: не удалось извлечь cookies
                    completion(.failure(NSError(domain: "CookieError", code: -3, userInfo: [NSLocalizedDescriptionKey: "Не удалось извлечь cookies из ответа."])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

