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
    
    func requestItems(query: String, start: Int, sortOption: SortOptions,
                      completionHandler: @escaping (SearchResponse) -> Void) {
        let url = StoreAPI.url
        let parameters: Parameters = [
            "query": query,
            "start": start,
            "display": 30,
            "sort": sortOption.rawValue
        ]
        
        AF.request(url, parameters: parameters, headers: StoreAPI.header).responseDecodable(of: SearchResponse.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
