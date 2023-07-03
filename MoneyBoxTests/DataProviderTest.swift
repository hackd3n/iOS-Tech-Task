//
//  DataProviderTest.swift
//  MoneyBoxTests
//
//  Created by Denis Hackett on 03/07/2023.
//

import Networking
import XCTest
@testable import MoneyBox

class DataProviderTests: XCTestCase {
    
    var mock: DataProviderMock!
    
    override func setUp() {
        super.setUp()
        
        mock = DataProviderMock()
    }
    
    override func tearDown() {
        mock = nil
        
        super.tearDown()
    }
    
    func testFetchProducts() {
        // Given
        let expectation = self.expectation(description: "Fetch Products")
        
        mock.fetchProducts { result in
            // Then
            switch result {
            case .success(let accountResponse):
                XCTAssertNotNil(accountResponse.productResponses)
                
                //expected number from product responses
                XCTAssertEqual(accountResponse.productResponses?.count, 2)
                
            case .failure(let error):
                
                //error message
                XCTFail("Failed to fetch products: \(error.localizedDescription)")
            }
            
            // Fulfill the expectation
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLogin() {
        
        let expectation = self.expectation(description: "Login")
        //login requires
        let loginRequest = LoginRequest(email: "test+ios2@moneyboxapp.com", password: "P455word12")
        
        mock.login(request: loginRequest) { result in
            
            switch result {
            case .success(let loginResponse):

                //change to confirm responses are correct
                XCTAssertNotNil(loginResponse.user)
                XCTAssertEqual(loginResponse.user.firstName, "Michael")
                XCTAssertEqual(loginResponse.user.lastName, "Jordan")
                
                XCTAssertNotNil(loginResponse.session)
                XCTAssertEqual(loginResponse.session.bearerToken, "GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs=")
                
            case .failure(let error):
                // error message
                XCTFail("Failed to login: \(error.localizedDescription)")
            }

            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    
}

