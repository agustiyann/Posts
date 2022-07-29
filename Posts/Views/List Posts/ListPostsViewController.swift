//
//  ViewController.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 29/07/22.
//

import UIKit

class ListPostsViewController: UIViewController {

    private let tableViewPosts: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel: ListPostsViewModel = ListPostsViewModel(useCase: PostsUseCase())
    
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
        viewModel.didLoad()
    }
    
    private func bindViewModel() {
        viewModel.didReceiveData = { [weak self] in
            self?.tableViewPosts.reloadData()
        }
        
        viewModel.didReceiveError = { error in
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
        let cell = tableViewPosts.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        let data = viewModel.listPosts[indexPath.row]
        cell.titlePostLabel.text = "\(data.title)"
        cell.bodyLabel.text = "\(data.body)"
        return cell
    }
}

// MARK: - TableView Delegate

extension ListPostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
