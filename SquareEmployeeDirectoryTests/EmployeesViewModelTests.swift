//
//  EmployeesViewModelTests.swift
//  SquareEmployeeDirectoryTests
//
//  Created by Reed Carson on 5/17/22.
//

import XCTest
@testable import SquareEmployeeDirectory

class MockNetworkService: NetworkService {
    func fetch<R>(_ request: R) async throws -> R.Model where R : AnyRequest {
        guard let url = Bundle.main.url(forResource: "MockEmployeesList", withExtension: "json") else {
            throw NetworkError.invalidUrl
        }
        
        let data = try Data(contentsOf: url, options: .mappedIfSafe)
        return try JSONDecoder().decode(R.Model.self, from: data)
    }
}

class EmployeesViewModelTests: XCTestCase {
    
    var employeesViewModel: EmployeesViewModel!

    override func setUpWithError() throws {
        let networkService = MockNetworkService()
        employeesViewModel = EmployeesViewModel(networkService: networkService)
    }
    
    func test_employeesLoaded() {
        let predicate = NSPredicate { any, _ -> Bool in
            guard let vm = (any as? EmployeesViewModel) else {
                return false
                
            }
            return vm.employees.count > 0
        }
        
        let exp = expectation(for: predicate, evaluatedWith: employeesViewModel, handler: nil)
        print(employeesViewModel.employees.count)
        wait(for: [exp], timeout: 1)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
