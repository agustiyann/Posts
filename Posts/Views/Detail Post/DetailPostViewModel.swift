//
//  DetailPostViewModel.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import Foundation

class DetailPostViewModel {
    
    // MARK: - Properties
    let useCase: DetailPostUseCase
    var listComments = [CommentModel]()
    
    // MARK: - Init
    init(useCase: DetailPostUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var didReceiveComments: (() -> Void)?
    var didReceiveErrorComments: ((String) -> Void)?
    
    // MARK: - Input
    func didLoadComments(postId: Int) {
        var comments: NetworkResult<[CommentModel]>?
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        useCase.fetchPostComments(postID: postId) { listComment in
            comments = listComment
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            guard let result = comments else {
                self.didReceiveErrorComments?("Found error in network")
                return
            }
            
            switch result {
            case .success(let data):
                self.listComments = data
                self.didReceiveComments?()
            case let .failed(message):
                self.didReceiveErrorComments?(message)
            }
        }
    }
}
