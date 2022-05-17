//
//  EmployeeTableViewCell.swift
//  SquareEmployeeDirectory
//
//  Created by Reed Carson on 5/17/22.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "EmployeeCellReuseIdentifier"
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var teamLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var phoneLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var biographyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var labelContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func addViews() {
        addSubview(labelContainerView)
        labelContainerView.addSubview(nameLabel)
        labelContainerView.addSubview(teamLabel)
        labelContainerView.addSubview(phoneLabel)
        labelContainerView.addSubview(emailLabel)
        addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        labelContainerView.snp.makeConstraints { make in
            make.leading.top.equalTo(self).offset(Constants.padding)
            make.bottom.equalTo(self).offset(-Constants.padding)
            make.trailing.equalTo(self).multipliedBy(0.5)
            make.height.equalTo(120)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(-Constants.padding)
            make.trailing.equalTo(self).offset(-Constants.padding)
            make.height.equalTo(Constants.photoHeight)
            make.width.equalTo(photoImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(labelContainerView).offset(Constants.padding)
            make.trailing.equalTo(labelContainerView)
        }
        
        teamLabel.snp.makeConstraints { make in
            make.leading.equalTo(labelContainerView).offset(Constants.padding)
            make.trailing.equalTo(labelContainerView)
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.padding)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(teamLabel.snp.bottom).offset(Constants.padding)
            make.leading.equalTo(labelContainerView).offset(Constants.padding)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(Constants.padding)
            make.leading.equalTo(labelContainerView).offset(Constants.padding)
            make.trailing.equalTo(labelContainerView).offset(-Constants.padding)
        }
    }
    
    func configure(with model: EmployeeCellModel) {
        nameLabel.text = model.name
        teamLabel.text = model.team
        phoneLabel.text = model.phone
        emailLabel.text = model.email
        biographyLabel.text = model.biography
    }
    
    struct Constants {
        static let photoHeight = 15
        static let padding: CGFloat = 5
        static let cornerRadius: CGFloat = 5
    }
}
