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
    @Published var errorMessage: String? = nil
    
    private var currentPage: Int = 1
    private var hasRequest: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var repo: CharactersWebRepoProtocol

    init(repo: CharactersWebRepoProtocol) {
        self.repo = repo
        //self.getCharacters()
    }
    
    var hasMore: Bool {
        return !(info?.next == nil)
    }
    
    init(characters: [CharacterModel], info: InfoModel) {
        self.characters = characters
        self.info = info
        self.repo = CharactersWebRepo(baseURL: "")
    }
    
    func getCharacters(withPage page: Int = 1, withText: String? = nil, cancelPrevious: Bool = false) {
        if cancelPrevious {
            cancellableSet.removeAll()
            hasRequest = true
        } else if hasRequest { return }
        
        self.hideLoader = false
        
        
        repo.loadCharacters(withPage: page, searchText: withText)
            .sink { [weak self] (response) in
                if self?.currentPage == 1 || page == 1 {
                    self?.characters.removeAll()
                }
                if response.error != nil {
                    self?.errorMessage = response.error?.backendError?.error
                    self?.hideLoader = true
                    self?.hasRequest = false
                } else {
                    
                    self?.characters.append(contentsOf: response.value?.results ?? [])
                    
                    self?.info = response.value?.info
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self?.hideLoader = true
                        self?.hasRequest = false
                    })
                    
                }
            }.store(in: &cancellableSet)
    }
    
    func getNextCharactersIfExist(withText: String? = nil) {
        guard let totalPages = self.info?.pages else { return }
        
        if currentPage < totalPages {
            currentPage += 1
            getCharacters(withPage: currentPage, withText: withText)
        }
    }
}

