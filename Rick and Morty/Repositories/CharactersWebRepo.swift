//
//  CharactersWebRepo.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 1/7/23.
//

import Foundation
import Combine
import Alamofire

protocol CharactersWebRepoProtocol {
    func loadCharacters(withPage page: Int) -> AnyPublisher<DataResponse<CharactersModel, NetworkError>, Never>
    func loadCharacter(withID id: Int) -> AnyPublisher<DataResponse<CharacterModel, NetworkError>, Never>
}

class CharactersWebRepo: CharactersWebRepoProtocol {
    
    let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func loadCharacters(withPage page: Int = 1) -> AnyPublisher<DataResponse<CharactersModel, NetworkError>, Never> {
        return AF.request(baseURL, parameters: ["page": page])
            .validate()
            .publishDecodable(type: CharactersModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func loadCharacter(withID id: Int) -> AnyPublisher<DataResponse<CharacterModel, NetworkError>, Never> {
        return AF.request(baseURL + "\(id)")
            .validate()
            .publishDecodable(type: CharacterModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
