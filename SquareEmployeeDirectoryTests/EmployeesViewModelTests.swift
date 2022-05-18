//
//  EmployeesViewModelTests.swift
//  SquareEmployeeDirectoryTests
//
//  Created by Reed Carson on 5/17/22.
//

import XCTest
@testable import SquareEmployeeDirectory

class EmployeesViewModelTests: XCTestCase {
    
    var employeesViewModel: EmployeesViewModel!
    var networkService: MockNetworkService!

    override func setUpWithError() throws {
        networkService = MockNetworkService()
        employeesViewModel = EmployeesViewModel(networkService: networkService)
    }
    
    func test_employeesLoaded() {
        let predicate = NSPredicate { any, _ -> Bool in
            guard let vm = (any as? EmployeesViewModel) else {
                return false
            }
            
            return vm.employees.count == 11
        }

        let exp = expectation(for: predicate, evaluatedWith: employeesViewModel, handler: nil)
        wait(for: [exp], timeout: 10)
    }

    override func tearDownWithError() throws {
        networkService = nil
        employeesViewModel = nil
    }
}
