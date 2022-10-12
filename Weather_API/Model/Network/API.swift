//
//  API.swift
//  Weather_API
//
//  Created by 阿瑋 on 2022/10/1.
//

import Foundation

class API : NSObject {
    
    static let shared = API()
    
    enum WeatherDataFetchError: Error {
        case invalidURL
        case requestFailed
        case responseFailed
        case jsonDecodeFailed
    }
    
    func requestData<D: Decodable>(city: String,
                                   completion: @escaping (Result<D, WeatherDataFetchError>) -> Void) {
                
        let urlRequest = handleHTTPMethod(method: .get, path: .weather)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else {
                print("Error: \(error?.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                completion(.failure(.responseFailed))
                return
            }
            print("Status Code: \(response.statusCode)")
            
            let decoder = JSONDecoder()
            guard let weatherData = try? decoder.decode(D.self, from: data) else {
                completion(.failure(.jsonDecodeFailed))
                return
            }
            
            #if DEBUG
            print("============== Weather Data ==============")
            print(weatherData)
            print("============== Weather Data ==============")
            #endif
            
            completion(.success(weatherData))
        }.resume()
    }
    
    private func handleHTTPMethod(method: NetworkConstants.HTTPMethod,
                                  path: NetworkConstants.APIPathConstants) -> URLRequest {
        let baseURL = NetworkConstants.baseURL
        let url = URL(string: baseURL + path.rawValue)!
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = method.rawValue
        
        switch method {
        case .get:
            let parameters = [
                "Authorization" : NetworkConstants.apikey,
                "locationName" : City_select.shared.city_check
            ]
            urlRequest.url = requestWithURL(urlString: urlRequest.url?.absoluteString ?? "", parameters: parameters)
        default:
            break
        }
        return urlRequest
    }
    
    private func requestWithURL(urlString: String,
                                parameters: [String : String]?) -> URL? {
        guard var urlComponents = URLComponents(string: urlString) else { return nil }
        urlComponents.queryItems = []
        parameters?.forEach { (key, value) in
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        return urlComponents.url
    }
}
