//
//  Structs.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 1/7/23.
//

import Foundation

import Foundation
import Alamofire

struct NetworkError: Error {
    let initialError: AFError
    let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var error: String
}
