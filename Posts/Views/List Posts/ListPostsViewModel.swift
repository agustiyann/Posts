//
//  ListPostsViewModel.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 29/07/22.
//

import Foundation

class ListPostsViewModel {
    
    // MARK: - Properties
    let useCase: PostsNetworkProvider
    var listPosts: [PostModel] = []
    
    // MARK: - Init
    init(useCase: PostsNetworkProvider) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var didReceiveData: (() -> Void)?
    var didReceiveError: ((String) -> Void)?
    
    // MARK: - Input
    func didLoad() {
        var result: NetworkResult<[PostModel]>?
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        useCase.fetchListPosts { posts in
            result = posts
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            guard let result = result else {
                self.didReceiveError?("Found error in network")
                return
            }
            
            switch result {
            case let .success(result):
                self.listPosts = result
                self.didReceiveData?()
            case let .failed(message):
                self.didReceiveError?(message)
            }
        }
    }
    
}
