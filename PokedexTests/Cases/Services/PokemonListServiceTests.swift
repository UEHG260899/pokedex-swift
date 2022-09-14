//
//  PokemonListServiceTests.swift
//  PokedexTests
//
//  Created by Uriel Hernandez Gonzalez on 16/08/22.
//

import XCTest
@testable import Pokedex

class PokemonListServiceTests: XCTestCase {

    var sut: PokemonListService!
    var networker: Networker!
    
    override func setUp() {
        super.setUp()
        networker = Networker()
        sut = PokemonListService(networker: networker)
    }
    
    override func tearDown() {
        sut = nil
        networker = nil
        super.tearDown()
    }
    
    func testIfPokemonListServiceCanBeInstantiated() {
        XCTAssertNotNil(sut)
    }
    
    func testIfComponentsVarIsCreated() {
        // when
        let components = sut.components
        
        // then
        XCTAssertNotNil(components)
    }
    
    func testIfPokemonsFunctionReturnsSuccessFromAValidURLRequest() {
        // given
        let expectation = XCTestExpectation(description: "Response from request")
        
        // then
        sut.pokemons(limit: 50, offset: 0) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(let error):
                print(error)
                assertionFailure()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5)
    }

}
