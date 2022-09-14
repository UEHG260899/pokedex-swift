//
//  NetworkerTests.swift
//  PokedexTests
//
//  Created by Uriel Hernandez Gonzalez on 15/08/22.
//

import XCTest
@testable import Pokedex

class NetworkerTests: XCTestCase {

    var sut: Networker!
    var validRequest: URLRequest!
    var invalidRequest: URLRequest!
    
    override func setUp() {
        super.setUp()
        sut = Networker()
        validRequest = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/ditto")!)
        invalidRequest = URLRequest(url: URL(string: "Hola")!)
    }
    
    override func tearDown() {
        sut = nil
        validRequest = nil
        invalidRequest = nil
        super.tearDown()
    }
        
    func testIfNetworkerCanBeInstantiated() {
        // then
        XCTAssertNotNil(sut)
    }
    
    func testIfResponseMethodReturnsStatusCode200WithValidRequest() {
        // given
        let expectation = XCTestExpectation(description: "Response for network call")
        var testValue = 0
        // when
        sut.response(for: validRequest) { response in
            switch response {
            case .success((let urlResponse, _)):
                testValue = urlResponse.statusCode
                expectation.fulfill()
            case .failure(_):
                assertionFailure()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(testValue, 200)
    }
    
    func testIfResponseMethodReturnsErrorWhenRequestIsInvalid() {
        // given
        let expectation = XCTestExpectation(description: "Response for network call")
        // when
        
        sut.response(for: invalidRequest) { response in
            switch response {
            case .success((_, _)):
                assertionFailure()
            case .failure(_):
                expectation.fulfill()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 10)
    }
    
    func testIfDataMethodReturnsDataWhenRequestIsValid() {
        // given
        let expectation = XCTestExpectation(description: "Response for network call")
        var tesData: Data? = nil
        // when
        sut.data(for: validRequest) { response in
            switch response {
            case .success(let data):
                tesData = data
                expectation.fulfill()
            case .failure(_):
                assertionFailure()
            }
        }
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(tesData)
    }
    
    func testIfDataMethodReturnsErrorWhenRequestIsNotValid() {
        // given
        let expectation = XCTestExpectation(description: "Response for network call")
        
        // when
        sut.data(for: invalidRequest) { response in
            switch response {
            case .success(_):
                assertionFailure()
            case .failure(_):
                expectation.fulfill()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 10)
    }
    
    func testIfDecodableMethodReturnsAModelWhenRequestIsValid() {
        // given
        let jsonRequest = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts/1")!)
        let expectation = XCTestExpectation(description: "Response for network call")
        var testableValue: MockPost!
        
        // when
        sut.decodable(for: jsonRequest, type: MockPost.self) { result in
            switch result {
            case .success(let model):
                testableValue = model
                expectation.fulfill()
            case .failure(_):
                assertionFailure()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(testableValue, MockPost(id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto", userId: 1))
    }
    
    func testIfDecodableMethodReturnsErrorWhenRequestIsInvalid() {
        // given
        let expectation = XCTestExpectation(description: "Response for network call")
        
        // when
        sut.decodable(for: invalidRequest, type: MockPost.self) { result in
            switch result {
            case .success(_):
                assertionFailure()
            case .failure(_):
                expectation.fulfill()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 5)
    }
}
