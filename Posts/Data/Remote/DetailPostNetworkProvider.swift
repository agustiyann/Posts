//
//  DetailPostNetworkProvider.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import Foundation

protocol DetailPostNetworkProvider {
    func fetchPostComments(postID: Int, completion: @escaping ((NetworkResult<[CommentModel]>) -> Void))
}

struct DetailPostUseCase: DetailPostNetworkProvider {
    func fetchPostComments(postID: Int, completion: @escaping ((NetworkResult<[CommentModel]>) -> Void)) {
        let urlString = "\(Cons.baseURL)/posts/\(postID)/comments"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failed("Found error from network"))
                return
            }
            guard let data = data else {
                completion(.failed("The data received from the server was invalid"))
                return
            }
            
            do {
                let comments = try JSONDecoder().decode([CommentModel].self, from: data)
                completion(.success(comments))
            } catch {
                completion(.failed("Failed when decoding"))
            }
        }.resume()
    }
}
