//
//  EmployeesViewModel.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/16/22.
//

import Foundation
import UIKit

protocol EmployeesViewModelDelegate: AnyObject {
    func didLoad(with error: Error?)
    func didLoad(with state: EmployeesViewModel.State)
}

class EmployeesViewModel {
    enum State {
        case loadedSuccess
        case loadedError(Error)
        case loadedEmpty
        case loading
        case notLoaded
    }
    
    var employees: [Employee] = []
    weak var delegate: EmployeesViewModelDelegate?
    
    private var networkService: NetworkService
    // private var cachingService: CachingService
    private var state: State = .notLoaded
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        
        Task { await load() }
    }
    
    func load() async {
        do {
            let list = try await networkService.fetch(EmployeeListRequest())
            employees = list.employees
            state = employees.isEmpty ? .loadedEmpty : .loadedSuccess
        } catch {
            state = .loadedError(error)
        }
        
        delegate?.didLoad(with: state)
    }
    
    func getEmployess(sort: SortType = .unsorted) -> [Employee] {
        switch sort {
        case .unsorted:
            return employees
        default:
            return employees
        }
    }
    
    func getImage(for id: UUID) async -> UIImage {
        return UIImage()
    }
    
}

enum SortType {
    case unsorted
    case alphabetical
    case team
}
