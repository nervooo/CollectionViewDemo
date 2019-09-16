//
//  TypeAlias.swift
//  Resturant
//
//  Created by Nervana Adel on 9/15/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import Foundation

/// A type that can convert itself into and out of an external representation.
typealias APIClinet = APIClientRequestForURLSession // APIClientRequestForAlamofire

typealias JSONDictionary = [String: AnyObject]

typealias CallResponse<T> = ((NetworkResult<T>) -> Void)?
typealias ResultResponse<T> = ((Result<T, Error>) -> Void)
