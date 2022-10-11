//
//  API.swift
//  Weather_API
//
//  Created by 阿瑋 on 2022/10/1.
//

import Foundation

class API : NSObject {
    static let shared = API()
    var place : [String] = []
    
    enum WeatherDataFetchError: Error {
        case invalidURL
        case requestFailed
        case responseFailed
        case jsonDecodeFailed
    }
    
    
    func requestData<D: Decodable>(city: String, completion: @escaping (Result<D,WeatherDataFetchError>) -> Void) {
        let address = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?"
        let apikey = "CWB-B9FA219A-E255-43FA-A977-A21FE2FD257B"
        
        guard let url = URL(string: address + "Authorization=\(apikey)&locationName=\(city)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
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
  
}
