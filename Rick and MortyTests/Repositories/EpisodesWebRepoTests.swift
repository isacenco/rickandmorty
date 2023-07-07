//
//  EpisodesWebRepoTests.swift
//  Rick and MortyTests
//
//  Created by Ghenadie Isacenco on 7/7/23.
//

import XCTest
@testable import Rick_and_Morty
import Combine

final class EpisodesWebRepoTests: XCTestCase {
    
    let repo = EpisodesWebRepo(baseURL: Constants.BASE_URL_EPISODES)
    var cancellableSet: Set<AnyCancellable> = []
    var episode: EpisodeModel?
    var errorMessage: String? = nil

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_loadEpisode() throws {
        let expec = expectation(description: "wait")
        
        let episodeNumber = 1
        repo.loadEpisode(withID: episodeNumber)
            .sink { [weak self] (response) in
                if response.error != nil {
                    self?.errorMessage = response.error?.backendError?.error
                } else {
                    if let results = response.value {
                        self?.episode = results
                    } else {
                        
                    }
                }
                expec.fulfill()
            }.store(in: &cancellableSet)
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertEqual(episode?.name, "Pilot")
        XCTAssertEqual(episode?.episode, "S01E01")
    }


}
