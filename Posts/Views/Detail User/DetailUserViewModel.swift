//
//  DetailUserViewModel.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import Foundation

class DetailUserViewModel {
    
    // MARK: - Properties
    let useCase: DetailUserUseCase
    var listAlbums = [AlbumModel]()
    
    // MARK: - Init
    init(useCase: DetailUserUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var didReceiveAlbums: (() -> Void)?
    var didReceiveErrorAlbums: ((String) -> Void)?
    
    // MARK: - Input
    func didLoadAlbums(userID: Int) {
        var albums: NetworkResult<[AlbumModel]>?
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        useCase.fetchUserAlbums(userId: userID) { listAlbum in
            albums = listAlbum
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            guard let result = albums else {
                self.didReceiveErrorAlbums?("Found error in network")
                return
            }
            
            switch result {
            case .success(let data):
                self.listAlbums = data
                self.didReceiveAlbums?()
            case let .failed(message):
                self.didReceiveErrorAlbums?(message)
            }
        }
    }
    
}
