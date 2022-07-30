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
    var listUsers: [UserModel] = []
    
    // MARK: - Init
    init(useCase: PostsNetworkProvider) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var didReceivePosts: (() -> Void)?
    var didReceiveUsers: (() -> Void)?
    var didReceiveErrorPosts: ((String) -> Void)?
    var didReceiveErrorUsers: ((String) -> Void)?
    
    // MARK: - Input
    func didLoadPosts() {
        var posts: NetworkResult<[PostModel]>?
        var users: NetworkResult<[UserModel]>?
        
        let dispatchGroup = DispatchGroup()
        
        /// Task 1 -- Get List Posts
        dispatchGroup.enter()
        useCase.fetchListPosts { listPost in
            posts = listPost
            guard let result = posts else {
                self.didReceiveErrorPosts?("Found error in network")
                return
            }
            switch result {
            case let .success(result):
                DispatchQueue.main.async {
                    self.listPosts = result
                    self.didReceivePosts?()
                }
            case let .failed(message):
                self.didReceiveErrorPosts?(message)
            }
            dispatchGroup.leave()
        }
        
        /// Task 2 -- Get List Users
        dispatchGroup.enter()
        useCase.fetchListUsers { listPost in
            users = listPost
            guard let result = users else {
                self.didReceiveErrorUsers?("Found error in network")
                return
            }
            switch result {
            case let .success(result):
                DispatchQueue.main.async {
                    self.listUsers = result
                    self.didReceiveUsers?()
                }
            case let .failed(message):
                self.didReceiveErrorUsers?(message)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Done main")
        }
    }
    
}
