//
//  NetworkService.swift
//  MusicByApple
//
//  Created by lion on 11.06.22.
//

import UIKit
import Alamofire

final class NetworkService {
    func fetchTracks(searchText: String, completion: @escaping (SearchResponseModel?) -> ()) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term" : "\(searchText)",
                          "limit" : "10",
                          "media" : "music"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { dataResponse in
            
            if let error = dataResponse.error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            let decoder = JSONDecoder()
            
            do {
                let objects = try decoder.decode(SearchResponseModel.self, from: data)
                print(objects)
                completion(objects)
                
            } catch let error as NSError {
                print(error.localizedDescription)
                completion(nil)
            }
//
//            let someString = String(data: data, encoding: .utf8)
//            print(someString ?? "hren")
        }
    }
}
