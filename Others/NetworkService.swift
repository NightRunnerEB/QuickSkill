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
    
    let jar = HTTPCookieStorage.shared
    
    // Ленивая инициализация для 'session', чтобы использовать 'manager'
    private lazy var session: Session = {
        let manager = ServerTrustManager(evaluators: ["localhost": DisabledTrustEvaluator()])
        return Session(serverTrustManager: manager)
    }()
    
    private init() { }
    
    // Функция для обновления токена
    func refreshToken(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let refreshToken = KeychainManager.shared.getRefreshToken(), let token = KeychainManager.shared.getUserToken() else {
            completion(.failure(NSError(domain: "Token not found", code: -1, userInfo: [NSLocalizedDescriptionKey: "Токены не найдены"])))
            return
        }
        
        guard let url = URL(string: "https://localhost:443/api/auth/refresh") else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        let parameters = AuthResponse(accessToken: token, refreshToken: refreshToken)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(parameters)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        print("Токен: \(token)")
        print("Refresh Токен: \(refreshToken)")
        
        
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
    
    func performGETRequest<T: Decodable>(to urlString: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Неверный URL"])))
            return
        }
        
        // Добавляем параметры запроса, если они есть
        if let parameters = parameters, !parameters.isEmpty {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Невозможно сформировать URL с параметрами"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Указываем метод запроса
        request.timeoutInterval = 10 // Установка интервала времени ожидания
        
        // Установка заголовков
        var updatedHeaders = HTTPHeaders()
        if let headers = headers {
            updatedHeaders = headers
        }
        updatedHeaders.add(name: "Content-Type", value: "application/json") // Это может быть не нужно для GET запросов
        request.headers = updatedHeaders
        
        // Выполнение запроса с использованием Alamofire
        session.request(request)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in

                switch response.result {
                case .success(let value):
                    print("Успех! Получены обьекты: \(value.self)")
                    completion(.success(value))
                case .failure(let error):
                    if let statusCode = response.response?.statusCode, statusCode == 401 {
                        // Токен истек, нужно обновить
                        self.refreshToken { result in
                            switch result {
                            case .success:
                                // Обновляем токен и повторяем запрос
                                self.performGETRequest(to: urlString, parameters: parameters, headers: headers, completion: completion)
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    } else {
                        if let data = response.data, let rawString = String(data: data, encoding: .utf8) {
                            print("Ответ сервера: \(rawString)")
                        }
                        completion(.failure(error))
                    }
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
        session.request(request)
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
                    if let data = response.data, let rawString = String(data: data, encoding: .utf8) {
                        print("Ответ сервера: \(rawString)")
                    }
                    
                    guard let statusCode = response.response?.statusCode else {
                        completion(.failure(NSError(domain: "UnknownError", code: 0, userInfo: nil)))
                        return
                    }
                    
                    if statusCode == 401 {
                        // Токен истек, нужно обновить
                        self.refreshToken { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success:
                                    // Обновляем токен и повторяем запрос
                                    self.performRequest(to: urlString, method: method, parameters: parameters, headers: headers, completion: completion)
                                case .failure(let error):
                                    completion(.failure(error))
                                }
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
                print("200")
                completion(.success(()))
            case 400:
                // Неправильное тело запроса
                print("400")
                completion(.failure(NSError(domain: "BadRequest", code: 400, userInfo: [NSLocalizedDescriptionKey: "Неправильное тело запроса."])))
            case 409:
                // Ошибка на сервере
                print("409")
                completion(.failure(NSError(domain: "ServerError", code: 409, userInfo: [NSLocalizedDescriptionKey: "Пользователь с такой почтой уже существует."])))
            default:
                print("Иди нахуй")
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
            guard let httpResponse = response.response else {
                completion(.failure(NSError(domain: "NoResponse", code: 0, userInfo: [NSLocalizedDescriptionKey: "No response from server."])))
                return
            }
            
            switch httpResponse.statusCode {
            case 200:
                // Извлекаем cookies из заголовков ответа
                if let headerFields = httpResponse.allHeaderFields as? [String: String], let url = httpResponse.url {
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
                    
                    // Ищем нужный cookie
                    if let userTokenCookie = cookies.first {
                        // Сохраняем значение токена в Keychain
                        print("Найден токен: \(userTokenCookie.value)")
                        KeychainManager.shared.saveUserToken(userTokenCookie.value)
                        HTTPCookieStorage.shared.setCookie(userTokenCookie)
                    } else {
                        // Ошибка: cookie с токеном не найден
                        completion(.failure(NSError(domain: "TokenError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Токен пользователя не найден в cookies."])))
                    }
                    
                    // Проверяем и сохраняем refresh токен из тела ответа
                    if let data = response.data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                            if let refreshToken = json?["refreshToken"] as? String { // "refresh_token" нужно заменить на ключ, который использует ваш сервер
                                KeychainManager.shared.saveRefreshToken(refreshToken)
                                print("Найден refresh токен: \(refreshToken)")
                                completion(.success(()))
                            } else {
                                completion(.failure(NSError(domain: "TokenError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Refresh token not found in response."])))
                            }
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(NSError(domain: "ResponseError", code: -3, userInfo: [NSLocalizedDescriptionKey: "Couldn't parse response data."])))
                    }
                    
                } else {
                    // Ошибка: не удалось извлечь cookies
                    completion(.failure(NSError(domain: "CookieError", code: -3, userInfo: [NSLocalizedDescriptionKey: "Не удалось извлечь cookies из ответа."])))
                }
                
            case 400:
                // Обработка неверного запроса
                completion(.failure(NSError(domain: "BadRequest", code: 400, userInfo: [NSLocalizedDescriptionKey: "Bad request - perhaps the data provided is invalid."])))
                
            case 404:
                // Обработка ошибки "не найдено"
                completion(.failure(NSError(domain: "NotFound", code: 404, userInfo: [NSLocalizedDescriptionKey: "Not found - the requested resource does not exist."])))
                
            default:
                // Обработка других ошибок
                if let error = response.error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "UnknownError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "An unknown error occurred with status code \(httpResponse.statusCode)."])))
                }
            }
        }
    }
}

