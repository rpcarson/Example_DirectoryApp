//
//  EmployeesViewController.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/16/22.
//

import UIKit
import SnapKit
import Kingfisher

class EmployeesViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
       let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()
    
    private let viewModel: EmployeesViewModel
    
    init(viewModel: EmployeesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupSelf()
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSelf() {
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: EmployeeTableViewCell.reuseIdentifier)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
    }
    
    @objc private func refresh() {
        Task { await viewModel.load() }
    }
}

extension EmployeesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.reuseIdentifier)
                as? EmployeeTableViewCell else {
            return UITableViewCell()
        }
        
        if let model = viewModel.getCellConfiguration(for: indexPath.row) {
            cell.configure(with: model)
        }
        
        viewModel.getImage(for: indexPath.row) { result in
            switch result {
            case .success((let image, let id)):
                if id == self.viewModel.employeeForIndex(indexPath.row)?.idString {
                    cell.setImage(image)
                }
            case .failure(let error):
                print(error)
                /// in case of failure here, we would load a placeholder image and log the error. the user probably does not need to receive feedback of any kind when the image fails to load - simply loading a placeholder that indiciates a missing image would be helpful, so that the users activity is not interupted and they can continue using the app
            }
        }

        return cell
    }
}

extension EmployeesViewController: EmployeesViewModelDelegate {
    func didLoad(with state: EmployeesViewModel.VMState) {
        switch state {
        case .loadedError(let error):
            print("Error: \(error.localizedDescription)")
        default:
            print("state \(state)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}
