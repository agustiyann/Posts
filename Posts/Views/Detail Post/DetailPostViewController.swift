//
//  DetailPostViewController.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import UIKit

class DetailPostViewController: UIViewController {
    
    var post: PostModel?
    var user: UserModel?
    
    var viewModel = DetailPostViewModel(useCase: DetailPostUseCase())
    
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .green
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .green
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
        label.backgroundColor = .green
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(commentsLabel)
        
        titleLabel.text = post?.title
        nameLabel.text = user?.name
        bodyLabel.text = post?.body

        NSLayoutConstraint.activate([
            
            // constrain scrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            // constrain contentView
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8.0),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8.0),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0.0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0.0),
            
            // constrain title label
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
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
            commentsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
            
        ])
        
        bindViewModel()
        viewModel.didLoadComments(postId: post?.id ?? 1)
    }
    
    private func bindViewModel() {
        viewModel.didReceiveComments = { [weak self] in
            if let comments = self?.viewModel.listComments {
                self?.commentsLabel.text = "\(comments.count) Comments"
            }
        }
        
        viewModel.didReceiveErrorComments = { error in
            print(error)
        }
    }

}
