//
//  CharactersWebRepoTests.swift
//  Rick and MortyTests
//
//  Created by Ghenadie Isacenco on 7/7/23.
//

import XCTest
@testable import Rick_and_Morty
import Combine

final class CharactersWebRepoTests: XCTestCase {
    
    let repo = CharactersWebRepo(baseURL: Constants.BASE_URL_CHARACTERS)
    
    var cancellableSet: Set<AnyCancellable> = []
    var currentPage = 1
    var characters = [CharacterModel]()
    var errorMessage: String? = nil
    var hideLoader: Bool = true
    var info: InfoModel?
    var hasRequest: Bool = false
    var character: CharacterModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_loadAllCharacters() throws {
        let expec = expectation(description: "wait")
        let page = 1
        
        repo.loadCharacters(withPage: page, searchText: nil)
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
                expec.fulfill()
            }.store(in: &cancellableSet)
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(characters.count, 20)
        XCTAssertEqual(info?.pages, 42)
        XCTAssertEqual(info?.count, 826)
    }
    
    func test_loadAllCharacters_page2() throws {
        let expec = expectation(description: "wait")
        let page = 2
        
        self.currentPage = 2
        
        repo.loadCharacters(withPage: page, searchText: nil)
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
                expec.fulfill()
            }.store(in: &cancellableSet)
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(characters.count, 20)
        XCTAssertEqual(info?.pages, 42)
        XCTAssertEqual(info?.count, 826)
    }
    
    func test_loadCharacterWithID() throws {
        let expec = expectation(description: "wait")
        let characterID = 1
        
        repo.loadCharacter(withID: characterID)
            .sink { [weak self] (response) in
                if response.error != nil {
                    self?.errorMessage = response.error?.backendError?.error
                } else {
                    if let results = response.value {
                        self?.character = results
                        //self?.getEpisode()
                    } else {
                        
                    }
                }
                expec.fulfill()
            }.store(in: &cancellableSet)
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(character?.name, "Rick Sanchez")
        XCTAssertEqual(character?.status, "Alive")
    }
    
    func test_loadCharactersWithQuery() throws {
        let expec = expectation(description: "wait")
        let page = 1
        let searchText = "Summer"
        
        repo.loadCharacters(withPage: page, searchText: searchText)
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
                expec.fulfill()
            }.store(in: &cancellableSet)
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(characters.count, 12)
        let charactersSummer = self.characters.filter { ($0.name ?? "").contains(searchText)}
        XCTAssertEqual(charactersSummer.count, 12)
    }
    
    func test_loadCharacters_NoResults() throws {
        let expec = expectation(description: "wait")
        let page = 1
        let searchText = "asdasdasd"
        let errMessage = "There is nothing here"
        
        repo.loadCharacters(withPage: page, searchText: searchText)
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
                expec.fulfill()
            }.store(in: &cancellableSet)
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(self.errorMessage)
        XCTAssertEqual(self.errorMessage, errMessage)
    }

}
