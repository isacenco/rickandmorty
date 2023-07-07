//
//  DetailViewModelTests.swift
//  Rick and MortyTests
//
//  Created by Ghenadie Isacenco on 7/7/23.
//

import XCTest
@testable import Rick_and_Morty

final class DetailViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_customInit() throws {
        let viewModel = DetailViewModel(character: CharacterModel.mockedData)
        
        XCTAssertEqual(viewModel.character?.name, "Rick Sanchez")
        XCTAssertEqual(viewModel.getStatusColorHex(), Colors.greenHex)
        XCTAssertEqual(viewModel.getSpeciensAndGenderText(), "Human - Male")
    }



}
