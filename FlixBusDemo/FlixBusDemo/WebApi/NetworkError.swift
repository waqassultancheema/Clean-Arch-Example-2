//
//  NetworkError.swift
//  FlixAppDemo
//
//  Created by Waqas Sultan on 7/26/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import Foundation


enum NetworkError: Error {
    case noNetwork
    case serverError(String)
    case parsingError(String)
    case unknown(String)
    case other(String)
}

extension NetworkError: LocalizedError {
    
    var localizedDescription : String {
        
        switch self {
        case .noNetwork:
            return "Please check your internet connection."
        case .serverError(let error):
            return error
        case .parsingError(let error):
            return error
        case .unknown(let error):
            return error
        case .other(let error):
            return error
        }
    }
}
