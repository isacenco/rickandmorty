//
//  EpisodeModel.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 5/7/23.
//

import Foundation

struct EpisodeModel: Codable {
    let id: Int?
    let name, airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
