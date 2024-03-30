//
//  NetworkServiceWithAlamofire.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 15.03.2024.
//

import Alamofire
import Combine
import Foundation

class NetworkServiceWithCombine {
    static let shared = NetworkServiceWithCombine()
    
    // Ленивая инициализация для 'session', чтобы использовать 'manager'
    lazy var session: Session = {
        let manager = ServerTrustManager(evaluators: ["localhost": DisabledTrustEvaluator()])
        return Session(serverTrustManager: manager)
    }()
    
    private init() { }
    
    func fetchData<T: Decodable>(from urlString: String, token: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NSError(domain: "InvalidURL", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        // Создаем URLRequest и настраиваем его
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Устанавливаем метод запроса
        request.setValue(token, forHTTPHeaderField: "great-cookie") // Устанавливаем токен авторизации
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Устанавливаем заголовок Content-Type
        
        // Возвращаем публикатор, который выполняет запрос и декодирует ответ
        return AF.request(request)
            .publishData(emptyResponseCodes: Set([200, 204, 205])) // Указание этих кодов в emptyResponseCodes говорит публикатору, что отсутствие тела ответа при получении этих кодов статуса не должно рассматриваться как ошибка.
            .tryMap { response -> Data in
                guard let data = response.data else {
                    throw AFError.responseValidationFailed(reason: .dataFileNil)
                }
                return data
            }
            .decode(type: T.self, decoder: {
                let decoder = JSONDecoder();
                decoder.keyDecodingStrategy = .convertFromSnakeCase;
                return decoder }())
            .eraseToAnyPublisher()
    }
    
    func postData<U: Encodable>(to urlString: String, token: String, requestData: U) -> AnyPublisher<Void, Error> {
        guard let url = URL(string: urlString) else {
            return Fail<Void, Error>(error: NSError(domain: "InvalidURL", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        // Создаем URLRequest и настраиваем его для POST запроса
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(token, forHTTPHeaderField: "great-cookie")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(requestData)
            request.httpBody = jsonData
        } catch {
            return Fail<Void, Error>(error: error)
                .eraseToAnyPublisher()
        }
        
        // Используем Alamofire для отправки запроса и возвращаем результат в виде публикатора
        return AF.request(request)
            .publishData() // Создаем публикатор Combine
            .tryMap { response in
                // Проверяем HTTP статус код
                guard let httpResponse = response.response, httpResponse.statusCode == 200 else {
                    throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: response.response?.statusCode ?? 0))
                }
                // Возвращаем пустой результат в случае успеха
                return ()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchAndPostData<T: Decodable, U: Encodable>(to urlString: String, token: String, requestData: U) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NSError(domain: "InvalidURL", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        // Создаем URLRequest и настраиваем его для POST запроса
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(requestData)
            request.httpBody = jsonData
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        // Используем Alamofire для выполнения запроса и возвращаем результат в виде публикатора
        return AF.request(request)
            .publishData()
            .tryMap { response in
                guard let data = response.data else {
                    throw AFError.responseValidationFailed(reason: .dataFileNil)
                }
                return data
            }
            .decode(type: T.self, decoder: {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return decoder
            }())
            .eraseToAnyPublisher()
    }
}
