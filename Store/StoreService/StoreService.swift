//
//  StoreService.swift
//  Store
//
//  Created by J Oh on 6/20/24.
//

import Foundation

final class StoreService {
    static let shared = StoreService()
    private init() { }
    
    func request<T: Decodable>(query: String, start: Int, sortOption: SortOptions, model: T.Type,
                               completionHandler: @escaping (Result<T, ResponseError>) -> Void) {
        
        var component = URLComponents(url: StoreAPI.url, resolvingAgainstBaseURL: false)!
        component.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "start", value: "\(start)"),
            URLQueryItem(name: "display", value: "30"),
            URLQueryItem(name: "sort", value: sortOption.rawValue)
        ]
        
        var request = URLRequest(url: component.url!, timeoutInterval: 10)
        request.setValue(StoreAPI.idKey, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(StoreAPI.secretKey, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completionHandler(.failure(.failedRequest))
                    return
                }
                
                guard let data else {
                    print("No Data Returned")
                    completionHandler(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completionHandler(.failure(.invalidResponse))
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completionHandler(.failure(.failedRequest))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(result))
                    print("Success")
                } catch {
                    print("Error")
                    completionHandler(.failure(.invalidData))
                }
            }
        }.resume()
        
    }
    
    enum ResponseError: Int, Error {
        case failedRequest = 401
        case noData = 403
        case invalidResponse // 404
        case invalidData // 405
    }
    
}


