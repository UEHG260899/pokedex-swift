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
    
    override func setUp() {
        super.setUp()
        networker = Networker()
        sut = PokemonListView.PokemonListViewModel(networker: networker)
    }
    
    override func tearDown() {
        networker = nil
        sut = nil
        super.tearDown()
    }
    
    func testIfNetworkerIsSetOnInit() {
        XCTAssertTrue(networker === sut.networker)
    }
    
    func testIfQueryIsEmptyOnInit() {
        XCTAssertEqual(sut.query, "")
    }
    
    func testIfNetworkStateIsLoadingByDefault() {
        XCTAssertEqual(sut.networkState, .loading)
    }

}
