//
//  MockedData.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 1/7/23.
//

import Foundation
#if DEBUG

extension CharactersModel {
    static let mockedData: [CharacterModel] = [
        
        CharacterModel(id: 1,
                       name: "Rick Sanchez",
                       status: "Alive",
                       species: "Human",
                       type: "",
                       gender: "Male",
                       origin: OriginModel(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                       location: LocationModel(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                       image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                       episode: ["https://rickandmortyapi.com/api/episode/1"],
                       url: "https://rickandmortyapi.com/api/character/1",
                       created: "2017-11-04T18:48:46.250Z"),
        
        CharacterModel(id: 2,
                       name: "Morty Smith",
                       status: "Alive",
                       species: "Human",
                       type: "",
                       gender: "Male",
                       origin: OriginModel(name: "unknown", url: nil),
                       location: LocationModel(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                       image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                       episode: ["https://rickandmortyapi.com/api/episode/1"],
                       url: "https://rickandmortyapi.com/api/character/2",
                       created: "2017-11-04T18:50:21.651Z")
        
    ]
}

extension CharacterModel {
    static let mockedData: CharacterModel = CharacterModel(id: 1,
                                                           name: "Rick Sanchez",
                                                           status: "Alive",
                                                           species: "Human",
                                                           type: "",
                                                           gender: "Male",
                                                           origin: OriginModel(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                                                           location: LocationModel(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                                                           image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                                           episode: ["https://rickandmortyapi.com/api/episode/1"],
                                                           url: "https://rickandmortyapi.com/api/character/1",
                                                           created: "2017-11-04T18:48:46.250Z")
}

extension InfoModel {
    static var mockedData: InfoModel = InfoModel(count: 826, pages: 42, next: "https://rickandmortyapi.com/api/character?page=2", prev: nil)

}

#endif
