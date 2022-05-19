//
//  MockUserRepository.swift
//  Code_ChallengeTests
//
//  Created by Stefan Nestorov on 19.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import Foundation
@testable import Code_Challenge

class MockUserRepository: UserRepositoryProtocol {
    
    @Published var isLoggedIn: Bool = false
    var isLoggedInPublisher: Published<Bool>.Publisher { $isLoggedIn }
    
    func login(dto: LoginDto) {
        isLoggedIn = true
    }
    
    func logout() {
        isLoggedIn = false
    }
    
}
