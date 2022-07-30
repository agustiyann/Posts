//
//  DetailUserContent.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import Foundation
import UIKit

class DetailUserContent: UITableViewHeaderFooterView {
    
    static let identifier = "DetailUserContent"
    
    var user: UserModel?
    
    // MARK: - Views
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        
        [nameLabel, emailLabel, addressLabel, companyLabel].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(user: UserModel) {
        self.user = user
        
        nameLabel.text = user.name
        emailLabel.text = "📧 \(user.email)"
        addressLabel.text = "🏠 \(user.address.street), \(user.address.suite), \(user.address.city)"
        companyLabel.text = "🏢 \(user.company.name)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            // name
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // email
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // address
            addressLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // company
            companyLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 4),
            companyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            companyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            companyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
        ])
    }
    
}
