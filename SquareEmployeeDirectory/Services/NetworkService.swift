//
//  NetworkService.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/16/22.
//

import Foundation

protocol NetworkService: AnyObject {
    func fetch<R: AnyRequest>(_ request: R) async throws -> R.Model
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
