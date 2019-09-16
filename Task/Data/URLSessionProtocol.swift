//
//  URLSessionProtocol.swift
//  XingRepos
//
//  Created by Nervana Adel on 9/15/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
}
