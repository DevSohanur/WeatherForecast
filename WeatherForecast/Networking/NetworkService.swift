//
//  NetworkService.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 3/6/23.
//

import Foundation

enum EnumRequestMethod: String, Codable {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
    case OPTIONS
}

enum ApiError: String, Error {
    case No_Network_Connection
    case Invalid_URL_Provided
    case No_Data_Found
}

class NetworkService {
    
    static func RestApiRequest<T: Codable>(urlString: String, method: EnumRequestMethod = .GET , headers: [String: String]? = nil, parameters: [String: Any]? = nil, queryParameters: [String: String]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(.failure(ApiError.No_Network_Connection))
        }
        else{
            
            guard var urlComponents = URLComponents(string: urlString) else {
                completion(.failure(ApiError.Invalid_URL_Provided))
                return
            }
            
            // Set query parameters
            if let queryParameters = queryParameters {
                urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            }
            
            guard let url = urlComponents.url else {
                completion(.failure(ApiError.Invalid_URL_Provided))
                return
            }
            
            print("Requested Rest Api: \(url)")
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            // Setting Headers
            if let headers = headers {
                for (key, value) in headers {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }
            
            // Setting parameters if provided
            if let parameters = parameters {
                let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            }
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Checking For Any Error
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // Checking For Data Existance
                guard let data = data else {
                    completion(.failure(ApiError.Invalid_URL_Provided))
                    return
                }
                
                // Converting Data to Response Model
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
}
