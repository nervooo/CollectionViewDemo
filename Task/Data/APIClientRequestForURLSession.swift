//
//  APIClientRequestForURLSession.swift
//  RealEstate
//
//  Created by Nervana Adel on 9/15/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import Foundation
import Alamofire

class APIClientRequestForURLSession {
    // create and initialize URLSession with a default session configuration
    var defaultSession: URLSessionProtocol = URLSession(configuration: URLSessionConfiguration.default)
    // declare a URLSessionDataTask which you'll use to make an HTTP request
    var dataTask: URLSessionDataTask?
    
    init() {
    }
    
    convenience init(configuration: URLSessionProtocol) {
        self.init()
        defaultSession = configuration
    }
    
    func invoke(request: URLRequest, completionHandler: @escaping ResultResponse<Any>) {
        Alamofire.request(request).validate(statusCode: 200 ..< 300).responseJSON { response in
            print(response)
            switch response.result {
            case let .success(result):
                completionHandler(.success(result))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
        
    }
    

    func invokeGetURL(urlString: String, parameters: Parameters?, httpHeader: HTTPHeaders?, cashing: Bool = false, completionHandler: @escaping ResultResponse<Any> ) {
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: httpHeader).validate(statusCode: 200 ... 500).responseData { response in
            print("Response: \(response)")
            switch response.result {
            case let .success(value):
                if cashing, let urlResponse = response.response, let urlRequest = response.request {
                    let cachedURLResponse = CachedURLResponse(response: urlResponse, data: value, userInfo: nil, storagePolicy: .allowed)
                    URLCache.shared.storeCachedResponse(cachedURLResponse, for: urlRequest)
                }
                completionHandler(.success(value))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
        //            .responseString { response in
        //            print(response.request)
        //            print(response.result)
        //            print(response)
        //        }
        
    }
    
}

// Handling DataTask LifeCycle
extension APIClientRequestForURLSession {
    func startTask() {
        dataTask?.resume()
    }
    
    func cancelTask() {
        dataTask?.cancel()
    }
    
    func resumeTask() {
        dataTask?.resume()
    }
    
    func suspendTask() {
        dataTask?.suspend()
    }
}
