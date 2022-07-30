//
//  PostNetworkProvider.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 29/07/22.
//

import Foundation

protocol PostsNetworkProvider {
    func fetchListPosts(completion: @escaping ((NetworkResult<[PostModel]>) -> Void))
    func fetchListUsers(completion: @escaping ((NetworkResult<[UserModel]>) -> Void))
}

struct PostsUseCase: PostsNetworkProvider {
    
    func fetchListPosts(completion: @escaping ((NetworkResult<[PostModel]>) -> Void)) {
        let urlString = "\(Cons.baseURL)/posts"
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
    
    func fetchListUsers(completion: @escaping ((NetworkResult<[UserModel]>) -> Void)) {
        let urlString = "\(Cons.baseURL)/users"
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
                let posts = try JSONDecoder().decode([UserModel].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failed("Failed when decoding"))
            }
        }.resume()
    }
    
}
