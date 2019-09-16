//
//  NetworkResult.swift
//  XingRepos
//
//  Created by Nervana Adel on 9/15/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import Foundation

/// Used to represent whether a request was successful or encountered an error.
/// Commonly used closures to handle the session tasks
/// should always return result
///
/// - success: successful resulting value.
///
/// - failure: The request encountered an error resulting in a failure.

enum NetworkResult<T> {
    case success(T)
    case failure(NetworkErrorCodeForResponse)

    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }

    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: T? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

public enum ResponseStatus: Int {
    /// <summary>
    /// The failure state
    /// </summary>
    case faild = 0

    /// <summary>
    /// The success state
    /// </summary>
    case success = 1

    /// <summary>
    /// The not found state
    /// </summary>
    case notFound = 2

    /// <summary>
    /// The already exist state
    /// </summary>
    case alreadyExist = 3

    /// <summary>
    /// The invalid request object
    /// </summary>
    case invalidRequestObject = 4

    case unknown = 914 // unknown status come from backend
    case errorStatus = 913 // failure to get status code
    case errorInParsingResponse = 912 // error in Response
    case connectionError = 911
}
