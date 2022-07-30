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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        tableView.register(DetailPostContent.self, forHeaderFooterViewReuseIdentifier: DetailPostContent.identifier)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        bindViewModel()
        viewModel.didLoadComments(postId: post?.id ?? 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func bindViewModel() {
        viewModel.didReceiveComments = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.didReceiveErrorComments = { error in
            print(error)
        }
    }

}

// MARK: - TableView Data source

extension DetailPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell {
            let comment = viewModel.listComments[indexPath.row]
            cell.configure(name: comment.name, comment: comment.body)
            return cell
        }
        return UITableViewCell()
    }
    
}

// MARK: - TableView Delegate

extension DetailPostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailPostContent.identifier) as? DetailPostContent
        header?.configure(
            user: user!,
            post: post!,
            commentsCount: viewModel.listComments.count,
            navController: navigationController!)
        return header
    }
}
