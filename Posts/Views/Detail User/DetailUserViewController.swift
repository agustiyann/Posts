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
        tableView.register(DetailUserContent.self, forHeaderFooterViewReuseIdentifier: DetailUserContent.identifier)
        tableView.register(AlbumTableViewCell.nib(), forCellReuseIdentifier: AlbumTableViewCell.identifier)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier, for: indexPath) as? AlbumTableViewCell {
            if !viewModel.listAlbums.isEmpty {
                let albumFilter = viewModel.listAlbums.filter { $0.id == indexPath.row + 1}
                cell.configure(album: albumFilter[0])
            }
            return cell
        }
        return UITableViewCell()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
