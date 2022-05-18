//
//  MockNetworkService.swift
//  SquareEmployeeDirectoryTests
//
//  Created by Reed Carson on 5/18/22.
//

import Foundation
@testable import SquareEmployeeDirectory

class MockNetworkService: NetworkService {
    var isSuccess = false
    
    func fetch<R>(_ request: R) async throws -> R.Model where R : AnyRequest {
        guard let url = Bundle(for: type(of: self)).url(forResource: "MockEmployeesList", withExtension: "json") else {
            throw NetworkError.invalidUrl
        }
        
        let data = try Data(contentsOf: url, options: .mappedIfSafe)
        let employeeList = try JSONDecoder().decode(R.Model.self, from: data)
        isSuccess = true
        return employeeList
    }
}
