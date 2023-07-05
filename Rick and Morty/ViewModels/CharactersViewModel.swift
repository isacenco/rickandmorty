//
//  CharactersViewModel.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 1/7/23.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    @Published var characters = [CharacterModel]()
    @Published var info: InfoModel?
    @Published var hideLoader: Bool = true
    
    private var currentPage: Int = 1
    private var hasRequest: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var repo: CharactersWebRepoProtocol

    init(repo: CharactersWebRepoProtocol) {
        self.repo = repo
        self.getCharacters()
    }
    
    init(characters: [CharacterModel], info: InfoModel) {
        self.characters = characters
        self.info = info
        self.repo = CharactersWebRepo(baseURL: "")
    }
    
    func getCharacters(withPage page: Int = 1) {
        if hasRequest { return }
        else { hasRequest = true }
        
        self.hideLoader = false
        repo.loadCharacters(withPage: page)
            .sink { (response) in
                if response.error != nil {
                        // TODO: show error alert?
                } else {
                    if self.currentPage == 1 {
                        self.characters.removeAll()
                    }
                    
                    self.characters.append(contentsOf: response.value?.results ?? [])
                    
                    self.info = response.value?.info
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.hideLoader = true
                        self.hasRequest = false
                    })
                    
                }
            }.store(in: &cancellableSet)
    }
    
    func getNextCharactersIfExist() {
        guard let totalPages = self.info?.pages else { return }
        
        if currentPage < totalPages {
            currentPage += 1
            getCharacters(withPage: currentPage)
        }
    }
}

