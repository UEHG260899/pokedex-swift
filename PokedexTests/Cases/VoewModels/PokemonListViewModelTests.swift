//
//  PokemonListViewModelTests.swift
//  PokedexTests
//
//  Created by Uriel Hernandez Gonzalez on 03/09/22.
//

import XCTest
@testable import Pokedex

class PokemonListViewModelTests: XCTestCase {
    
    var sut: PokemonListView.PokemonListViewModel!
    var networker: Networker!
    var service: PokemonListServiceType!
    var mockService: MockPokemonListService {
        service as! MockPokemonListService
    }
    
    override func setUp() {
        super.setUp()
        networker = Networker()
        service = MockPokemonListService()
        sut = PokemonListView.PokemonListViewModel(service: service)
    }
    
    override func tearDown() {
        networker = nil
        service = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - When methods
    
    private func whenFetchPokemons() {
        let exp = expectation(description: "Completion wasn´t called")
        
        sut.fetchPokemons { _ in
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 0.2)
    }
        
    func testIfServiceIsSetOnInit() {
        XCTAssertNotNil(sut.service)
    }
    
    func testIfQueryIsEmptyOnInit() {
        XCTAssertEqual(sut.query, "")
    }
    
    func testIfNetworkStateIsLoadingByDefault() {
        XCTAssertEqual(sut.networkState, .loading)
    }
    
    func testIfPokemonsIsEmptyOnInit() {
        XCTAssertEqual(sut.pokemons.count, 0)
    }
    
    func testIfNetworkStateChangesToSuccessWhenSuccessfulResponse() {
        // given
        mockService.shouldCompleteSuccessfully = true
        
        
        // when
        whenFetchPokemons()
        
        // then
        XCTAssertEqual(sut.networkState, .success)
    }

    func testIfNetworkStateChangesToFailureWhenErrorIsRecieved() {
        // given
        mockService.shouldCompleteSuccessfully = false
        
        // when
        whenFetchPokemons()
        
        // then
        XCTAssertEqual(sut.networkState, .failure)
    }
    
    func testIfPokemonsArrayCountChangesWhenResponseIsSuccessful() {
        // given
        mockService.shouldCompleteSuccessfully = true
        
        // when
        whenFetchPokemons()
        
        // then
        XCTAssertEqual(sut.pokemons.count, 4)
    }
}
