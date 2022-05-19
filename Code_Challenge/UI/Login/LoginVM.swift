//
//  LoginVM.swift
//  Code_Challenge
//
//  Created by Stefan Nestorov on 18.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import Foundation

class LoginVM: BaseVM {
    
    @Published var isLoggedIn:Bool
    @Published var name = ""
    @Published var password = ""
    private var userRepository: UserRepositoryProtocol = Resolver.resolve()
    
    override init() {
        isLoggedIn = userRepository.isLoggedIn
        super.init()
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        userRepository.isLoggedInPublisher
            .didSet
            .sink { [weak self] isLoggedIn in
                self?.isLoggedIn = isLoggedIn
            }
            .store(in: &cancellables)
        
    }
    
    func onLoginPressed() {
        Task { //Usually this will be async operations so we run them in a task to prevent blocking of the ui thread..
            userRepository.login(dto: LoginDto(name: name, password: password))
        }
    }
    
}
