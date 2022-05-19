//
//  FeedVM_Tests.swift
//  Code_ChallengeTests
//
//  Created by Stefan Nestorov on 19.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import XCTest
@testable import Code_Challenge
import Combine

class FeedVM_Tests: XCTestCase {

    private var userRepository: UserRepositoryProtocol?
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        Resolver.registerMockServices()
        userRepository = Resolver.optional()
        //In order to go to feed screen the user should be logged in
        userRepository?.login(dto: LoginDto(name: "user", password: "password"))
    }

    override func tearDownWithError() throws {
        userRepository = nil
        cancellables.removeAll()
    }

    func test_userIsLoggedInInitially() throws {
        let vm = FeedVM()
        XCTAssertTrue(vm.isLoggedIn)
    }
    
    func test_feedAvailable() throws {
        let vm = FeedVM()
        XCTAssertTrue(vm.feed.count > 0)
    }
    
    func test_onLogoutPressed() throws {
        
        let vm = FeedVM()
        XCTAssertTrue(vm.isLoggedIn)
        
        let expectation = XCTestExpectation(description: "isLoggedIn is set to false")
        vm.$isLoggedIn
            .didSet
            .dropFirst()
            .sink { isLoggedIn in
                if ( !isLoggedIn ) {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        vm.onLogoutPressed()
        
        wait(for: [expectation], timeout: 1)
        
    }

}
