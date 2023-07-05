//
//  DetailViewModel.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 3/7/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var character: CharacterModel?
    @Published var characterID: Int

    private var cancellableSet: Set<AnyCancellable> = []
    var repo: CharactersWebRepoProtocol
    
    init(repo: CharactersWebRepoProtocol, characterID: Int) {
        self.repo = repo
        self.characterID = characterID
    }
    
    init(character: CharacterModel) {
        self.character = character
        self.characterID = character.id ?? 0
        self.repo = CharactersWebRepo(baseURL: "")
    }
    
    func getCharacter() {
        repo.loadCharacter(withID: characterID)
            .sink { (response) in
                if response.error != nil {
                        // TODO: show error alert?
                } else {
                    if let results = response.value {
                        self.character = results
                    } else {
                        
                    }
                }
            }.store(in: &cancellableSet)
    }
}
