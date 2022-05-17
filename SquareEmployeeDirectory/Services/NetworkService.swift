//
//  NetworkService.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/16/22.
//

import Foundation

protocol AnyRequest {
    associatedtype Model: Decodable
    var url: String { get set }
}

protocol NetworkService: AnyObject {
    func fetch<R: AnyRequest>(_ request: R) async throws -> R.Model
}

enum NetworkError: LocalizedError {
    case invalidUrl
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid Url"
        }
    }
}

struct EmployeeListRequest: AnyRequest {
    typealias Model = EmployeeList
    var url: String = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
}

class EmployeesNetworkService: NetworkService {
    func fetch<R>(_ request: R) async throws -> R.Model where R : AnyRequest {
        guard let url = URL(string: request.url) else {
            throw NetworkError.invalidUrl
        }
        
        do {
            let result = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(R.Model.self, from: result.0)
        } catch {
            throw error
        }
    }
}
