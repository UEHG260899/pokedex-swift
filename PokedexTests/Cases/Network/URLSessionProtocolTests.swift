//
//  URLSessionProtocolTests.swift
//  PokedexTests
//
//  Created by Uriel Hernandez Gonzalez on 17/09/22.
//

import XCTest
@testable import Pokedex

final class URLSessionProtocolTests: XCTestCase {

    var sut: URLSession!
    var testRequest: URLRequest!
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
        testRequest = URLRequest(url: URL(string: "https://example.com")!)
    }
    
    override func tearDown() {
        sut = nil
        testRequest = nil
        super.tearDown()
    }

    func testURLSessionConformsToURLSessionProtocol() {
        XCTAssertTrue((sut as AnyObject) is URLSessionProtocol)
    }
    
    func testURLSessionDataTaskConformsToURLSessionTaskProtocol() {
        // given
        let task = sut.dataTask(with: testRequest)

        // then
        XCTAssertTrue((task as AnyObject) is URLSessionTaskProtocol)
    }
    
    func testURLSessionMakeDataTaskCreatesTaskWithPassedURLRequest() {
        // when
        let task = sut.makeDataTask(with: testRequest,
                                    completion: {_, _, _ in}) as! URLSessionTask
        
        // then
        XCTAssertEqual(task.originalRequest, testRequest)
    }
    
    func testURLSessionMakeDataTaskCreatesTaskWithPassedCompletion() {
        // given
        let exp = expectation(description: "Completion wasn´t called")
        
        // when
        let task = sut.makeDataTask(with: testRequest) { _, _, _ in
            exp.fulfill()
        } as! URLSessionTask
        task.cancel()
        
        // then
        waitForExpectations(timeout: 0.2)
    }

}
