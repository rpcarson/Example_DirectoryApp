//
//  EmployeesViewModel.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/16/22.
//

import UIKit
import Kingfisher

enum SortType {
    case unsorted
    case alphabetical
    case team
}

protocol EmployeesViewModelDelegate: AnyObject {
    func didLoad(with state: EmployeesViewModel.VMState)
}

class EmployeesViewModel {
    enum VMState {
        case loadedSuccess
        case loadedError(Error)
        case loadedEmpty
        case loading
        case notLoaded
    }
    
    weak var delegate: EmployeesViewModelDelegate?
    
    private var employees: [Employee] = []
    private var networkService: NetworkService
    private var state: VMState = .notLoaded
    private var sortType: SortType = .team
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        Task { await load() }
    }
    
    func load() async {
        if case .loading = state { return }
        
        do {
            let list = try await networkService.fetch(EmployeeListRequest())
            employees = sort(list.employees)
            state = employees.isEmpty ? .loadedEmpty : .loadedSuccess
        } catch {
            state = .loadedError(error)
        }
        
        delegate?.didLoad(with: state)
    }

    func getNumberOfRows() -> Int {
        switch state {
        case .loadedSuccess:
            return employees.count
        case .loadedEmpty, .loadedError:
            return 1
        default:
            return 0
        }
    }
    
    func getImage(for index: Int, completion: @escaping ((Result<(UIImage, String), ImageFetchError>) -> Void)) {
        switch state {
        case .loadedSuccess:
            guard employees.indices.contains(index) else {
                completion(.failure(.noEmployeeFound(index: index)))
                return
            }
            
            getImage(for: employees[index]) { completion($0) }
        case .loadedError: break
        case .loadedEmpty: break
        default: break
        }
    }
    
    func getImage(for employee: Employee,
                  completion: @escaping ((Result<(UIImage, String), ImageFetchError>) -> Void)) {
        let cacheId = employee.idString
        
        guard let urlString = employee.photoUrlSmall,
              let url = URL(string: urlString) else {
                  completion(.failure(.missingImageUrlForEmployee(id: employee.idString)))
                  return
              }
        
        if ImageCache.default.isCached(forKey: cacheId) {
            ImageCache.default.retrieveImage(forKey: cacheId) {
                if let image = try? $0.get().image {
                    completion(.success((image, employee.idString)))
                } else {
                    completion(.failure(.couldNotGetCachedImaged(id: cacheId)))
                }
            }
        } else {
            getImageForUrl(url, employeeId: employee.idString) {
                completion($0)
            }
        }
    }
    
    private func getImageForUrl(_ url: URL,
                                employeeId: String,
                                completion: @escaping ((Result<(UIImage, String), ImageFetchError>) -> Void)) {
        let resource = ImageResource(downloadURL: url, cacheKey: employeeId)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil,
                                               progressBlock: nil,
                                               downloadTaskUpdated: nil) { result in
            switch result {
            case .success(let imageResult):
                completion(.success((imageResult.image, employeeId)))
            case .failure:
                completion(.failure(.couldNotRetriveImageAtUrl(url: url.absoluteString)))
            }
        }
    }
    
    func getCellConfiguration(for index: Int) -> EmployeeCellModel? {
        switch state {
        case .loadedSuccess:
            guard employees.indices.contains(index) else { return nil }
            return EmployeeCellModel(employee: employees[index])
        case .loadedError: return nil
        case .loadedEmpty: return nil
        default: return nil
        }
    }
    
    func employeeForIndex(_ index: Int) -> Employee? {
        guard employees.indices.contains(index) else { return nil }
        return employees[index]
    }
    
    private func sort(_ employees: [Employee]) -> [Employee] {
        switch sortType {
        case .unsorted:
            return employees
        case .alphabetical:
            return employees.sorted(by: { $0.fullName < $1.fullName })
        case .team:
            return employees.sorted(by: { $0.team < $1.team })
        }
    }
}
