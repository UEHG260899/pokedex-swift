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
    var mockSession: MockURLSession!
    var mockTask: MockURLSessionDataTask!
    var validRequest: URLRequest!
    var invalidRequest: URLRequest!
    
    var dummyData: Data {
        "Test Data".data(using: .utf8)!
    }
    
    var dummyValidResponse: HTTPURLResponse {
        HTTPURLResponse(url: validRequest.url!, statusCode: 200, httpVersion: "", headerFields: [:])!
    }
    
    var dummyInvalidResponse: URLResponse {
        URLResponse(url: invalidRequest.url!, mimeType: "application/json", expectedContentLength: 3414, textEncodingName: "utf-8")
    }
    
    var dummyError: Error {
        NSError(domain: "com.pokedex", code: 10)
    }
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        sut = Networker(session: mockSession)
        validRequest = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon?offset=41&limit=50")!)
        invalidRequest = URLRequest(url: URL(string: "Hola")!)
    }
    
    override func tearDown() {
        mockSession = nil
        mockSession = nil
        sut = nil
        validRequest = nil
        invalidRequest = nil
        super.tearDown()
    }
    
    // MARK: - Given functions
    private func givenDataFromFile(name: String) -> Data? {
        let path = Bundle(for: NetworkerTests.self).path(forResource: name, ofType: "json")!
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
    
    // MARK: - When functions
    private func whenSimpleResposeMethodCalled() {
        mockTask = sut.response(for: validRequest, completion: {_ in}) as! MockURLSessionDataTask
    }
    
    private func whenResponseMethodCalled(data: Data? = nil,
                                          response: URLResponse? = nil,
                                          error: Error? = nil) -> (calledCompletion: Bool, response: HTTPURLResponse?, data: Data?, error: NetworkerErrors?) {
        
        var calledCompletion = false
        var recievedError: NetworkerErrors? = nil
        var recievedData: Data? = nil
        var recievedResponse: HTTPURLResponse? = nil
        
        let task = sut.response(for: validRequest) { result in
            calledCompletion = true
            switch result {
            case .success((let response, let data)):
                recievedData = data
                recievedResponse = response
            case .failure(let error):
                recievedError = error
            }
            
        } as! MockURLSessionDataTask
        
        task.completionHandler(data, response, error)
        
        return (calledCompletion, recievedResponse, recievedData, recievedError)
    }
    
    private func whenDataMethodCalled(data: Data? = nil,
                                      response: URLResponse? = nil,
                                      error: Error? = nil) -> (calledCompletion: Bool, request: URLRequest?, data: Data?, error: NetworkerErrors?) {
        
        var calledCompletion = false
        var recievedRequest: URLRequest? = nil
        var recievedData: Data? = nil
        var recievedError: NetworkerErrors? = nil
        
        let task = sut.data(for: validRequest) { result in
            calledCompletion = true
            switch result {
            case .success(let data):
                recievedData = data
            case .failure(let error):
                recievedError = error
            }
        } as! MockURLSessionDataTask
        
        task.completionHandler(data, response, error)
        recievedRequest = task.request
        
        return (calledCompletion, recievedRequest, recievedData, recievedError)
    }
    
    private func whenDecodableMethodCalled<T: Decodable>(data: Data? = nil,
                                                         response: URLResponse? = nil,
                                                         error: Error? = nil,
                                                         type: T.Type) -> (calledCompletion: Bool, request: URLRequest?, decodedData: T?, error: NetworkerErrors?) {
        
        var calledCompletion = false
        var recievedRequest: URLRequest? = nil
        var recievedError: NetworkerErrors? = nil
        var recievedDecodedData: T? = nil
        
        let task = sut.decodable(for: validRequest, type: type) { result in
            calledCompletion = true
            switch result {
            case .success(let decodedData):
                recievedDecodedData = decodedData
            case .failure(let error):
                recievedError = error
            }
        } as! MockURLSessionDataTask
        
        recievedRequest = task.request
        task.completionHandler(data, response, error)

        return (calledCompletion, recievedRequest, recievedDecodedData, recievedError)
    }
        
    func testIfNetworkerCanBeInstantiated() {
        // then
        XCTAssertNotNil(sut)
    }
        
    func testIfNetworkerSessionSetsInInitializer() {
        XCTAssertTrue(sut.session === mockSession)
    }
    
    func testResponseMethodCallsExpectedURL() {
        // when
        whenSimpleResposeMethodCalled()
        
        // then
        XCTAssertEqual(mockTask.request, validRequest)
    }
    
    func testResponseMethodCallsResumeOnTask() {
        // when
        whenSimpleResposeMethodCalled()
        
        // then
        XCTAssertTrue(mockTask.calledResume)
    }
    
    func testResponseMethodCallsCompletion() {
        // given
        let result = whenResponseMethodCalled()
        
        // then
        XCTAssertTrue(result.calledCompletion)
    }
    
    func testResponseMethodThrowsUnknownErrorWhenNoDataIsRecieved() {
        // when
        let result = whenResponseMethodCalled(response: dummyValidResponse)
        
        // then
        XCTAssertEqual(result.error, .unknown)
    }
    
    func testResponseMethodThrowsUnknownErrorWhenNoResponseIsRecieved() {
        // when
        let result = whenResponseMethodCalled(data: dummyData)
        
        // then
        XCTAssertEqual(result.error, .unknown)
    }
    
    func testResponseMethodThrowsUnknownErrorWhenErrorIsNotNil() {
        // when
        let result = whenResponseMethodCalled(data: dummyData, response: dummyValidResponse, error: dummyError)
        
        // then
        XCTAssertEqual(result.error, .unknown)
        
    }
    
    func testResponseMethodThrowInvalidResponseWhenURLResponseIsNotValid() {
        // when
        let result = whenResponseMethodCalled(data: dummyData, response: dummyInvalidResponse)
        
        // then
        if case .invalidResponse(let error) = result.error {
            XCTAssertEqual(error.url, dummyInvalidResponse.url)
        } else {
            assertionFailure()
        }
    }
    
    func testResponseMethodCompletesWithDataAndResponseWhenNoErrors() {
        // when
        let result = whenResponseMethodCalled(data: dummyData, response: dummyValidResponse)

        // then
        XCTAssertNotNil(result.data)
        XCTAssertNotNil(result.response)
    }
    
    func testResponseMethodCompletesWithDataAndResponseEqualToDataTask() {
        // when
        let result = whenResponseMethodCalled(data: dummyData, response: dummyValidResponse)
        
        // then
        XCTAssertEqual(result.data, dummyData)
        XCTAssertEqual(result.response?.url, dummyValidResponse.url)
    }
    
    func testDataMethodCallsCompletion() {
        // given
        let result = whenDataMethodCalled()
        
        // then
        XCTAssertTrue(result.calledCompletion)
    }
    
    func testDataMethodUsesPassedInRequest() {
        // when
        let result = whenDataMethodCalled()
        
        // then
        XCTAssertEqual(result.request, validRequest)
    }
    
    func testDataMethodReturnsRequestFailedErrorWhenRequestFailed() {
        // given
        let badResponse = HTTPURLResponse(url: validRequest.url!, statusCode: 400, httpVersion: "", headerFields: [:])
        
        // when
        let result = whenDataMethodCalled(data: dummyData, response: badResponse)
        
        // then
        if case .requestFailed(let response) = result.error {
            XCTAssertEqual(response.url, badResponse?.url)
            XCTAssertEqual(response.statusCode, badResponse?.statusCode)
        } else {
            assertionFailure()
        }
    }
    
    func testDataMethodReturnsSameErrorAsReponseMethodWhenItFails() {
        // when
        let result = whenDataMethodCalled()
        
        // then
        XCTAssertEqual(result.error, .unknown)
    }
    
    func testDataMethodCompletesWithDataWhenNoErrorOcurred() {
        // when
        let result = whenDataMethodCalled(data: dummyData, response: dummyValidResponse)
        
        // then
        XCTAssertNotNil(result.data)
    }
    
    func testDataMethodCompletesWithSameDataAsTheOneRecievedByNetwork() {
        // when
        let result = whenDataMethodCalled(data: dummyData, response: dummyValidResponse)
        
        // then
        XCTAssertEqual(result.data, dummyData)
    }
    
    func testDecodableMethodCallsCompletion() {
        // when
        let result = whenDecodableMethodCalled(type: Pokemon.self)
                
        // then
        XCTAssertTrue(result.calledCompletion)
        
    }
    
    func testDecodableMethodUsesPassedInRequest() {
        // when
        let result = whenDecodableMethodCalled(type: Pokemon.self)
        
        // then
        XCTAssertEqual(result.request, validRequest)
    }
    
    func testDecodableMethodReturnsDeserializationFailedErrorWhenInvalidJsonIsRecieved() {
        // given
        let data = givenDataFromFile(name: "BadPokemonList")
        
        // when
        let result = whenDecodableMethodCalled(data: data, response: dummyValidResponse, type: PokemonList.self)
        
        // then
        if case .deserializationFailed(let string) = result.error {
            XCTAssertEqual(string, String(describing: PokemonList.self))
        } else {
            assertionFailure()
        }
    }
    
    func testDecodableMethodReturnsErrorWhenDataTaskReturnsError() {
        // when
        let result = whenDecodableMethodCalled(type: Pokemon.self)
        
        // when
        XCTAssertEqual(result.error, .unknown)
    }
    
    func testDecodableMethodReturnsWithDecodedDataWhenNetworkRequestIsSuccessful() {
        // given
        let data = givenDataFromFile(name: "ValidPokemonList")
        
        // when
        let result = whenDecodableMethodCalled(data: data, response: dummyValidResponse, type: PokemonList.self)
        
        // then
        XCTAssertTrue((result.decodedData as AnyObject) is PokemonList)
    }
    
}
