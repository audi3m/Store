//
//  StoreService.swift
//  Store
//
//  Created by J Oh on 6/20/24.
//

import Foundation
import Alamofire

class StoreService {
    static let shared = StoreService()
    
    private init() { }
    
    typealias completionHandler = (SearchResponse?, Error?) -> Void
    
//    func requestItems(query: String, start: Int, sortOption: SortOptions,
//                      completionHandler: @escaping (SearchResponse?, Error?) -> Void) {
//        let url = StoreAPI.url
//        let parameters: Parameters = [
//            "query": query,
//            "start": start,
//            "display": 30,
//            "sort": sortOption.rawValue
//        ]
//        
//        AF.request(url, parameters: parameters, headers: StoreAPI.header).responseDecodable(of: SearchResponse.self) { response in
//            switch response.result {
//            case .success(let value):
//                completionHandler(value, nil)
//            case .failure(let error):
//                print(error)
//                completionHandler(nil, error)
//            }
//        }
//    }
    
    func request<T: Decodable>(session: URLSession, query: String, start: Int, sortOption: SortOptions, model: T.Type,
                               completionHandler: @escaping (T?, ResponseError?) -> Void) {
        
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
        
        session.dataTask(with: request) { data, response, error in
//        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data else {
                    print("No Data Returned")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(result, nil)
                    print("Success")
                } catch {
                    print("Error")
                    completionHandler(nil, .invalidData)
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


