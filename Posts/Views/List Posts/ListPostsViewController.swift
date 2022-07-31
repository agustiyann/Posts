//
//  ViewController.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 29/07/22.
//

import UIKit

class ListPostsViewController: UIViewController {

    lazy private var tableViewPosts: UITableView = {
        let tableView = UITableView()
        tableView.registerNIB(with: PostTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let viewModel: ListPostsViewModel = ListPostsViewModel(useCase: PostsUseCase())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "List Posts"
        view.addSubview(tableViewPosts)
        
        tableViewPosts.delegate = self
        tableViewPosts.dataSource = self
        tableViewPosts.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableViewPosts.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableViewPosts.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableViewPosts.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        bindViewModel()
        viewModel.didLoadPosts()
    }
    
    private func bindViewModel() {
        viewModel.didReceivePosts = { [weak self] in
            self?.tableViewPosts.reloadData()
        }
        
        viewModel.didReceiveUsers = { [weak self] in
            self?.tableViewPosts.reloadData()
        }
        
        viewModel.didReceiveErrorPosts = { error in
            print(error)
        }
        
        viewModel.didReceiveErrorUsers = { error in
            print(error)
        }
    }

}

// MARK: - TableView Data Source

extension ListPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewPosts.dequeueCell(with: PostTableViewCell.self)!
        let data = viewModel.listPosts[indexPath.row]
        cell.titlePostLabel.text = "\(data.title)"
        cell.bodyLabel.text = "\(data.body)"
        if !viewModel.listUsers.isEmpty {
            let userFilter = viewModel.listUsers.filter { $0.id == data.userID }
            cell.companyLabel.text = userFilter[0].company.name
            cell.usernameLabel.text = userFilter[0].name
        }
        return cell
    }
}

// MARK: - TableView Delegate

extension ListPostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = viewModel.listPosts[indexPath.row]
        let detailVC = DetailPostViewController()
        detailVC.post = data
        if !viewModel.listUsers.isEmpty {
            let userFilter = viewModel.listUsers.filter { $0.id == data.userID }
            detailVC.user = userFilter[0]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
