//
//  NetworkResult.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 29/07/22.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failed(String)
}
