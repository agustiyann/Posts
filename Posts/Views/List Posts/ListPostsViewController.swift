//
//  ViewController.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 29/07/22.
//

import UIKit

class ListPostsViewController: UIViewController {

    private let tableViewPosts: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "List Posts"
        view.addSubview(tableViewPosts)
        
        tableViewPosts.delegate = self
        tableViewPosts.dataSource = self
        tableViewPosts.frame = view.bounds
    }

}

// MARK: - TableView Data Source

extension ListPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewPosts.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Number \(indexPath.row)"
        return cell
    }
}

// MARK: - TableView Delegate

extension ListPostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
