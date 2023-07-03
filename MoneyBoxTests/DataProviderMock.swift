//
//  LoginTest.swift
//  MoneyBoxTests
//
//  Created by Denis Hackett on 28/06/2023.
//

import Networking
@testable import MoneyBox

class DataProviderMock: DataProviderLogic {


    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        StubData.read(file: "LoginSucceed") { (result: Result<LoginResponse, Error>) in
            completion(result)
        }
    }

    func fetchProducts(completion: @escaping (Result<AccountResponse, Error>) -> Void) {
        StubData.read(file: "Accounts") { (result: Result<AccountResponse, Error>) in
            completion(result)
        }
    }

    func addMoney(request: OneOffPaymentRequest, completion: @escaping (Result<OneOffPaymentResponse, Error>) -> Void) {
        StubData.read(file: "OneOffPayment") { (result: Result<OneOffPaymentResponse, Error>) in
            completion(result)
        }
    }
}



