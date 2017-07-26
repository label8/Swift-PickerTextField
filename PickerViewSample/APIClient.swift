//
//  APIClient.swift
//  FirebaseSample
//
//  Created by Hachiya Tsunemasa on 2017/07/19.
//  Copyright © 2017年 Hachiya Tsunemasa. All rights reserved.
//

import Foundation

class APIClient {

    let session: URLSession = URLSession.shared
    
    func get(urlString: String, addValues: Array<Any>? = nil, queryItems: [URLQueryItem]? = nil, closure: @escaping (_ data: Any) -> Void) {
        let url = URL(string: urlString)
        var request: URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        if let values = addValues {
            for val in values {
                let data = val as! Dictionary<String, Any>
                request.addValue(data["value"] as! String, forHTTPHeaderField: data["forHTTPHeaderField"] as! String)
            }
        }
        
        var components = URLComponents(string: urlString)
        components?.queryItems = queryItems
        
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    closure(json)
                } catch {
                    print("Serialize Error")
                }
            } else {
                print(error ?? "Error")
            }

        }
        
        task.resume()
    }
    
}
