//
//  LoginVM_Tests.swift
//  Code_ChallengeTests
//
//  Created by Stefan Nestorov on 19.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import XCTest
@testable import Code_Challenge
import Combine

class LoginVM_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        Resolver.registerMockServices()
    }

    override func tearDownWithError() throws {
        cancellables.removeAll()
    }

    func test_userIsNotLoggedInInitially() throws {
        let vm = LoginVM()
        XCTAssertFalse(vm.isLoggedIn)
    }
    
    func test_onLoginPressed() throws {
        
        let vm = LoginVM()
        XCTAssertFalse(vm.isLoggedIn)
        let expectation = XCTestExpectation(description: "isLoggedIn is set to true")
        
        vm.$isLoggedIn
            .didSet
            .dropFirst()
            .sink { isLoggedIn in
                if ( isLoggedIn ) {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        vm.onLoginPressed()
        
        wait(for: [expectation], timeout: 1)
        
    }


}
