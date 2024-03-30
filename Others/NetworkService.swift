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
    
    func fetchData<T: Decodable>(from urlString: String, parameters: Parameters? = nil, token: String, completion: @escaping (Result<T?, Error>) -> Void) {
        // Кодирование параметров в URL, если они есть
        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        guard var urlComponents = URLComponents(string: encodedUrlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        // Добавление параметров к URL, если они предоставлены
        if let parameters = parameters, !parameters.isEmpty {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        // Создаем URLRequest и настраиваем его
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10 // Установка тайм-аута в 10 секунд
        
        // Установка заголовков
        let headers = HTTPHeaders([
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ])
        request.headers = headers
        
        // Выполняем запрос
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T?.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    if (error.asAFError?.underlyingError as NSError?)?.code == NSURLErrorTimedOut {
                        // Упрощённая обработка ошибки тайм-аута
                        completion(.failure(NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: [NSLocalizedDescriptionKey: "Медленная работа интернета!"])))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }
    
    func postData<T: Decodable>(to urlString: String, token: String, parameters: Parameters, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        // Создаем URLRequest и настраиваем его
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Изменяем метод запроса на POST
        request.timeoutInterval = 10 // Установка тайм-аута в 30 секунд
        
        // Настраиваем заголовки запроса
        let headers = HTTPHeaders([
            "Authorization": "Bearer \(token)", // Устанавливаем токен авторизации
            "Content-Type": "application/json" // Устанавливаем заголовок Content-Type
        ])
        request.headers = headers
        
        // Добавляем параметры в тело запроса
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        // Выполняем запрос
        AF.request(request)
            .validate(statusCode: 200..<300) // Проверяем, что статус-код ответа находится в допустимом диапазоне
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    if (error.asAFError?.underlyingError as NSError?)?.code == NSURLErrorTimedOut {
                        // Упрощённая обработка ошибки тайм-аута
                        completion(.failure(NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: [NSLocalizedDescriptionKey: "Медленная работа интернета!"])))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }
    
    func patchData(to urlString: String, token: String, parameters: Parameters, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        // Создаем URLRequest и настраиваем его
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH" // Используем метод PATCH
        request.timeoutInterval = 10 // Устанавливаем тайм-аут в 10 секунд
        
        // Настраиваем заголовки запроса
        let headers = HTTPHeaders([
            "Authorization": "Bearer \(token)", // Устанавливаем токен авторизации
            "Content-Type": "application/json" // Устанавливаем заголовок Content-Type
        ])
        request.headers = headers
        
        // Добавляем параметры в тело запроса
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        // Выполняем запрос
        AF.request(request)
            .validate(statusCode: 200..<300) // Проверяем, что статус-код ответа находится в допустимом диапазоне
            .response { response in
                switch response.result {
                case .success(_):
                    completion(.success(())) // В случае успеха возвращаем Void
                case .failure(let error):
                    if (error.asAFError?.isSessionTaskError == true) && ((error.asAFError?.underlyingError as NSError?)?.code == NSURLErrorTimedOut) {
                        // Обработка ошибки тайм-аута
                        completion(.failure(NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: [NSLocalizedDescriptionKey: "Медленная работа интернета!"])))
                    } else {
                        completion(.failure(error)) // В случае другой ошибки возвращаем её
                    }
                }
            }
    }


    
    
    func registerUser(registrationData: RegistrationData, to urlString: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        // Создаем URLRequest и настраиваем его для POST запроса
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
                completion(.failure(NSError(domain: "ServerError", code: 409, userInfo: [NSLocalizedDescriptionKey: "Ошибка на сервере."])))
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
        
        // Создаем URLRequest и настраиваем его для POST запроса
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

