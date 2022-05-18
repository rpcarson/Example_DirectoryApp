//
//  Requests.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/17/22.
//

import Foundation

protocol AnyRequest {
    associatedtype Model: Decodable
    var url: String { get set }
}

struct EmployeeListRequest: AnyRequest {
    typealias Model = EmployeeList
    var url: String = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
}

struct MalformedEmployeesRequest: AnyRequest {
    typealias Model = EmployeeList
    var url: String = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
}

struct EmptyEmployeesRequest: AnyRequest {
    typealias Model = EmployeeList
    var url: String = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
}

