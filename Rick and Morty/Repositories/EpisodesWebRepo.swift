//
//  EpisodesWebRepo.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 5/7/23.
//

import Foundation
import Combine
import Alamofire

protocol EpisodesWebRepoProtocol {
    func loadEpisode(withID id: Int) -> AnyPublisher<DataResponse<EpisodeModel, NetworkError>, Never>
}

class EpisodesWebRepo: EpisodesWebRepoProtocol {
    
    let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func loadEpisode(withID id: Int) -> AnyPublisher<DataResponse<EpisodeModel, NetworkError>, Never> {
        return AF.request(baseURL + "\(id)")
            .validate()
            .publishDecodable(type: EpisodeModel.self)
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
