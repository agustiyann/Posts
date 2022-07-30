//
//  AlbumViewModel.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 31/07/22.
//

import Foundation

class AlbumViewModel {
    
    // MARK: - Properties
    let useCase: DetailUserUseCase
    var listPhotos = [PhotoModel]()
    
    // MARK: - Init
    init(useCase: DetailUserUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var didReceivePhotos: (() -> Void)?
    var didReceiveErrorPhotos: ((String) -> Void)?
    
    // MARK: - Input
    func didLoadAlbums(albumID: Int) {
        var photos: NetworkResult<[PhotoModel]>?
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        useCase.fetchAlbumPhotos(albumID: albumID) { listPhoto in
            photos = listPhoto
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            guard let result = photos else {
                self.didReceiveErrorPhotos?("Found error in network")
                return
            }
            
            switch result {
            case .success(let data):
                self.listPhotos = data
                self.didReceivePhotos?()
            case let .failed(message):
                self.didReceiveErrorPhotos?(message)
            }
        }
    }
    
}
