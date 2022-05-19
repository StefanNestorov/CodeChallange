//
//  AuthService.swift
//  Code_Challenge
//
//  Created by Stefan Nestorov on 18.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import Foundation

class AuthService: AuthServiceProtocol {
    
    var isLoggedIn: Bool
    
    init() {
        isLoggedIn = TwitterClient.shared.isLoggedIn.value
    }
    
    func login(dto: LoginDto) {
        TwitterClient.shared.logIn(username: dto.name, password: dto.password)
        isLoggedIn = TwitterClient.shared.isLoggedIn.value
    }
    
    func logout() {
        TwitterClient.shared.logOut()
        isLoggedIn = TwitterClient.shared.isLoggedIn.value
    }
    
}
