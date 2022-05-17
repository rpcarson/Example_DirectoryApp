//
//  EmployeeCellModel.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/17/22.
//

import Foundation

struct EmployeeCellModel {
    let name: String
    let team: String
    let email: String
    let phone: String?
    let imageUrl: String?
    let biography: String?
}

extension EmployeeCellModel {
    init(employee: Employee) {
        name = employee.fullName
        team = employee.team
        email = employee.emailAddress
        phone = employee.phoneNumber
        imageUrl = employee.photoUrlSmall
        biography = employee.biography
    }
}
