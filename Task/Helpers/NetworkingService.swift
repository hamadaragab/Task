//
//  NetworkingService.swift
//  Task
//
//  Created by Hamada Ragab on 09/01/2023.
//

import Foundation

class NetworkingService{
    class func MakeRequest<T:Decodable>(type: T.Type,url: String, method: HttpMethod, parameters: [String:Any?]? , completion: @escaping (Result<T,ErrorStatus>)->()) {
        if Reachability.isConnectedToNetwork(){
            guard let url = URL(string: url) else {
                return completion(.failure(.InvalidUrl)) }
            let headers: [String:String] = [:]
            var request = URLRequest(url:  url)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let parameters = parameters {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    print(error)
                }
            }
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let _ = error {
                    completion(.failure(.UnexpectedError))
                } else if let data = data {
                    do {
                        let responseData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(responseData))
                    }catch {
                        completion(.failure(.ParsingError))
                    }
                } else {
                    completion(.failure(.UnexpectedError))
                }
            }
            task.resume()
        }else {
            completion(.failure(.NoInternet))
        }
    }
}

