//
//  ImageFetchError.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/17/22.
//

import Foundation

enum ImageFetchError: LocalizedError {
    case couldNotGetCachedImaged(id: String)
    case couldNotRetriveImageAtUrl(url: String)
    case noEmployeeFound(index: Int)
    case missingImageUrlForEmployee(id: String)
    
    var errorDescription: String? {
        switch self {
        case .couldNotGetCachedImaged(let id):
            return "Could not get cached image with cache id: \(id)"
        case .couldNotRetriveImageAtUrl(let url):
            return "Could not retrieve image for url: \(url)"
        case .noEmployeeFound(let index):
            return "Employee not found: \(index)"
        case .missingImageUrlForEmployee(let id):
            return "Missing image url for employee: \(id)"
        }
    }
}
