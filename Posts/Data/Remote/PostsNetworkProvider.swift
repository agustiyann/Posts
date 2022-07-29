//
//  PostNetworkProvider.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 29/07/22.
//

import Foundation

protocol PostsNetworkProvider {
    func fetchListPosts(completion: @escaping ((NetworkResult<[PostModel]>) -> Void))
}

struct PostsUseCase: PostsNetworkProvider {
    func fetchListPosts(completion: @escaping ((NetworkResult<[PostModel]>) -> Void)) {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
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
                let posts = try JSONDecoder().decode([PostModel].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failed("Failed when decoding"))
            }
        }.resume()
    }
}
