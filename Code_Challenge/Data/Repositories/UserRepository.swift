//
//  UserRepository.swift
//  Code_Challenge
//
//  Created by Stefan Nestorov on 18.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import Foundation

class UserRepository: UserRepositoryProtocol {

    private var authService: AuthServiceProtocol = Resolver.resolve()
    @Published var isLoggedIn:Bool
    var isLoggedInPublisher: Published<Bool>.Publisher { $isLoggedIn }
    
    init() {
        self.isLoggedIn = authService.isLoggedIn
    }
    
    func login(dto: LoginDto) {
        authService.login(dto: dto)
        isLoggedIn = authService.isLoggedIn
    }
    
    func logout() {
        authService.logout()
        isLoggedIn = authService.isLoggedIn
    }
    
}
