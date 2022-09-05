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
    
    override func setUp() {
        super.setUp()
        networker = Networker()
        service = PokemonListService(networker: networker)
        sut = PokemonListView.PokemonListViewModel(service: service)
    }
    
    override func tearDown() {
        networker = nil
        service = nil
        sut = nil
        super.tearDown()
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
    
    func testIfPokemonsIsNotEmptyWhenFetchPokemonsIsCalled() {
        // when
        sut.fetchPokemons()
        
        // then
        XCTAssertTrue(!sut.pokemons.isEmpty)
    }
    
    func testIfNetworkStateIsChangedToSuccessWhenNetworkCallCompletes() {
        // given
        let exp = expectation(description: "Network call should complete")

        // when
        sut.fetchPokemons { _ in
            exp.fulfill()
        }
        
        // then
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(sut.networkState, .success)
    }

}
