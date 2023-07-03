//import XCTest
//@testable import Networking
//
//final class NetworkingTests: XCTestCase {
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct
//        // results.
//    }
//}


import XCTest
@testable import Networking

final class NetworkingTests: XCTestCase {
    func testLoginAPI() throws {
        
        let expectation = XCTestExpectation(description: "Login API completion called")
        
        let dataProvider = DataProvider()
        let loginRequest = LoginRequest(email: "test+ios2@moneyboxapp.com", password: "P455word12")


        dataProvider.login(request: loginRequest) { result in
            switch result {
            case .success(let loginResponse):
                
                //reponses contain expected
                XCTAssertNotNil(loginResponse.session.bearerToken)
                XCTAssertNotNil(loginResponse.user.firstName)
                XCTAssertNotNil(loginResponse.user.lastName)

                // test completed
                expectation.fulfill()
            case .failure(let error):
                // failed login request
                XCTFail("Login API failed with error: \(error)")
            }
        }
        
        dataProvider.fetchProducts{ result in
            switch result {
                case .success(let accountResponse):

                    XCTAssertNotNil(accountResponse.totalPlanValue)
                    XCTAssertNotNil(accountResponse.productResponses)
                    if let productResponses = accountResponse.productResponses {
                            XCTAssertNotNil(productResponses[0].planValue)
                        }
                case failure (let error):
                    XCTFail("Failed to fetch products: \(error)")
                }
        }
        
        dataProvider.addMoney(request: 10 { result in
            switch result {
            case .sucess (let )
            }
        }
        // Wait for the expectation to be fulfilled, or timeout after a specified duration
        wait(for: [expectation], timeout: 5.0)
    }
}

