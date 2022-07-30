//
//  DetailPostContent.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import Foundation
import UIKit

class DetailPostContent: UITableViewHeaderFooterView {
    
    static let identifier = "TableHeader"
    
    var user: UserModel?
    weak var navController: UINavigationController?
    
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .italicSystemFont(ofSize: 16)
        label.backgroundColor = .systemBlue
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        return view
    }()
    
    private lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "comments")
        return tableView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(commentsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(user: UserModel, post: PostModel, commentsCount: Int, navController: UINavigationController) {
        self.user = user
        self.navController = navController
        
        titleLabel.text = post.title
        nameLabel.text = user.name
        bodyLabel.text = post.body
        commentsLabel.text = "\(commentsCount) Comments"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(namePressed(_:)))
        nameLabel.isUserInteractionEnabled = true
        nameLabel.addGestureRecognizer(tap)
    }
    
    @objc private func namePressed(_ sender: UITapGestureRecognizer) {
        let vc = DetailUserViewController()
        vc.user = self.user
        navController?.pushViewController(vc, animated: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            // constrain title label
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            
            // constrain name label
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            
            // constraint body label
            bodyLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            
            // contraint line
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 10.0),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            
            // constraint comment label
            commentsLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10.0),
            commentsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            commentsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            commentsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
        ])
    }
}
