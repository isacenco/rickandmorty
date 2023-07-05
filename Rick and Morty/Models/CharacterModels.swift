//
//  Models.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 1/7/23.
//

import Foundation

import Foundation

struct CharactersModel: Codable {
    let info : InfoModel?
    let results : [CharacterModel]?
    
    enum CodingKeys: String, CodingKey {
        
        case info = "info"
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try values.decodeIfPresent(InfoModel.self, forKey: .info)
        results = try values.decodeIfPresent([CharacterModel].self, forKey: .results)
    }
    
    init(info: InfoModel, results: [CharacterModel]) {
        self.info = info
        self.results = results
    }
}

struct InfoModel: Codable {
    let count : Int?
    let pages : Int?
    let next : String?
    let prev : String?
    
    enum CodingKeys: String, CodingKey {
        
        case count = "count"
        case pages = "pages"
        case next = "next"
        case prev = "prev"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        pages = try values.decodeIfPresent(Int.self, forKey: .pages)
        next = try values.decodeIfPresent(String.self, forKey: .next)
        prev = try values.decodeIfPresent(String.self, forKey: .prev)
    }
    
    init(count: Int, pages: Int, next: String?, prev: String?) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

struct CharacterModel: Codable {
    let id : Int?
    let name : String?
    let status : String?
    let species : String?
    let type : String?
    let gender : String?
    let origin : OriginModel?
    let location : LocationModel?
    let image : String?
    let episode : [String]?
    let url : String?
    let created : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case status = "status"
        case species = "species"
        case type = "type"
        case gender = "gender"
        case origin = "origin"
        case location = "location"
        case image = "image"
        case episode = "episode"
        case url = "url"
        case created = "created"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        species = try values.decodeIfPresent(String.self, forKey: .species)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        origin = try values.decodeIfPresent(OriginModel.self, forKey: .origin)
        location = try values.decodeIfPresent(LocationModel.self, forKey: .location)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        episode = try values.decodeIfPresent([String].self, forKey: .episode)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        created = try values.decodeIfPresent(String.self, forKey: .created)
    }
    
    init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: OriginModel, location: LocationModel, image: String, episode: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

struct OriginModel : Codable {
    let name : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
    init(name: String, url: String?) {
        self.name = name
        self.url = url
    }
}

struct LocationModel : Codable {
    let name : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

