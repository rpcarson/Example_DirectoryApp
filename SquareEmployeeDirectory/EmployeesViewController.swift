//
//  EmployeesViewController.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/16/22.
//

import UIKit

class EmployeesViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        return tableView
    }()
    
    private let viewModel: EmployeesViewModel?
    
    init(viewModel: EmployeesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSelf() {
    }
    
}

extension EmployeesViewController: UITableViewDelegate {
    
}
