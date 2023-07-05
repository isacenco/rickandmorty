//
//  DetailViewModel.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 3/7/23.
//

import Foundation
import Combine
import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var character: CharacterModel?
    @Published var characterID: Int
    @Published var episode: EpisodeModel?

    private var cancellableSet: Set<AnyCancellable> = []
    var repoCharacters: CharactersWebRepoProtocol
    var repoEpisodes: EpisodesWebRepoProtocol
    
    init(repoCharacters: CharactersWebRepoProtocol, repoEpisodes: EpisodesWebRepoProtocol, characterID: Int) {
        self.repoCharacters = repoCharacters
        self.repoEpisodes = repoEpisodes
        self.characterID = characterID
    }
    
    init(character: CharacterModel) {
        self.character = character
        self.characterID = character.id ?? 0
        self.repoCharacters = CharactersWebRepo(baseURL: "")
        self.repoEpisodes = EpisodesWebRepo(baseURL: "")
    }
    
    func getCharacter() {
        repoCharacters.loadCharacter(withID: characterID)
            .sink { (response) in
                if response.error != nil {
                        // TODO: show error alert?
                } else {
                    if let results = response.value {
                        self.character = results
                        self.getEpisode()
                    } else {
                        
                    }
                }
            }.store(in: &cancellableSet)
    }
    
    func getEpisode() {
        guard let episode = character?.episode?.first?.split(separator: "/").last else { return }
        guard let episodeNumber: Int = Int(String(episode)) else { return }
        
        repoEpisodes.loadEpisode(withID: episodeNumber)
            .sink { (response) in
                if response.error != nil {
                        // TODO: show error alert?
                } else {
                    if let results = response.value {
                        self.episode = results
                    } else {
                        
                    }
                }
            }.store(in: &cancellableSet)
    }
    
    
    func getStatusColorHex() -> String {
        guard let status = character?.status else { return Colors.grayHex }
        
        switch status {
        case Constants.STATUS_ALIVE:
            return Colors.greenHex
        case Constants.STATUS_DEAD:
            return Colors.redHex
        default:
            return Colors.grayHex
        }
    }
    
    func getSpeciensAndGenderText() -> String {
        return (self.character?.species ?? "") + " - " + (self.character?.gender ?? "")
    }
}
