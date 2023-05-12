//
//  APIs.swift
//  Next_Tech
//
//  Created by Achintha kahawalage on 2023-05-10.
//

import Foundation

typealias CompletionHandlerWithData = (_ data: Data?, _ statusCode: Int?, _ error: Error?) -> ()

class APIs {
    
    static let shared = APIs()
    
    var urlSession: URLSession
    
    init(urlSession: URLSession = .shared){
        self.urlSession = urlSession
    }
    
    // MARK: - Fetch Search result requst
    // Used generics to make it as reusable
    func getAllData<T: Decodable>(url: URL, _ mapType: T.Type, completion: @escaping (_ response: T?,
                                                                                      _ code: Int?,
                                                                                      _ error: Error?) -> Void){
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            
            let httpResponse = response as? HTTPURLResponse
            
            do {
                if error == nil {
                    let data = data ?? Data()
                    let decoder = JSONDecoder()
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                    let response = try decoder.decode(T.self, from: jsonData)
                    
                    completion(response, httpResponse?.statusCode, nil)
                } else {
                    completion(nil, httpResponse?.statusCode, error)
                }
            } catch {
                completion(nil, httpResponse?.statusCode, error)
            }
        }
        task.resume()
    }
    
}
