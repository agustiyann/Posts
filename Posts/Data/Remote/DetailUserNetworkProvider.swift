//
//  DetailUserNetworkProvider.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import Foundation

protocol DetailUserNetworkProvider {
    func fetchUserAlbums(userId: Int, completion: @escaping ((NetworkResult<[AlbumModel]>) -> Void))
}

struct DetailUserUseCase: DetailUserNetworkProvider {
    func fetchUserAlbums(userId: Int, completion: @escaping ((NetworkResult<[AlbumModel]>) -> Void)) {
        let urlString = "\(Cons.baseURL)/albums/\(userId)/photos"
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
                let albums = try JSONDecoder().decode([AlbumModel].self, from: data)
                completion(.success(albums))
            } catch {
                completion(.failed("Failed when decoding"))
            }
        }.resume()
    }
}
