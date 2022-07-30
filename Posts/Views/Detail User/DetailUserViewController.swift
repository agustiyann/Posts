//
//  DetailUserViewController.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import UIKit

class DetailUserViewController: UIViewController {
    
    var user: UserModel?
    var viewModel = DetailUserViewModel(useCase: DetailUserUseCase())
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "albums")
        tableView.register(DetailUserContent.self, forHeaderFooterViewReuseIdentifier: DetailUserContent.identifier)
        tableView.backgroundColor = .systemBackground
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail User"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        bindViewModel()
        viewModel.didLoadAlbums(userID: user?.id ?? 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func bindViewModel() {
        viewModel.didReceiveAlbums = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.didReceiveErrorAlbums = { error in
            print(error)
        }
    }

}

// MARK: - TableView Data source

extension DetailUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albums", for: indexPath)
        let album = viewModel.listAlbums[indexPath.row]
        cell.textLabel?.text = album.title
        return cell
    }
}

// MARK: - TableView Delegate

extension DetailUserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailUserContent.identifier) as? DetailUserContent
        header?.configure(user: user!)
        return header
    }
}
