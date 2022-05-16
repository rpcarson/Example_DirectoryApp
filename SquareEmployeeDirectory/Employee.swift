//
//  Employee.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/16/22.
//

import Foundation

struct EmployeeList: Decodable {
    let employees: [Employee]
}

struct Employee: Decodable {
    let employeeId: UUID
    let fulleName: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    let team: String
    let employeeType: String
    
    enum Keys: String, CodingKey {
        case employeeId = "uuid",
             fullName = "full_name",
             phoneNumber = "phone_number",
             emailAddress = "email_address",
             photoUrlSmall = "photo_url_small",
             photoUrlLarge = "photo_url_large",
             employeeType = "employee_type"
    }
}
