//
//  NetworkError.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/17/22.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidUrl
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid Url"
        }
    }
}
