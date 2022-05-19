//
//  FeedVM.swift
//  Code_Challenge
//
//  Created by Stefan Nestorov on 19.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import Foundation

class FeedVM: BaseVM {
    
    @Published var isLoggedIn:Bool
    @Published var feed = [Tweet]()
    private var userRepository: UserRepositoryProtocol = Resolver.resolve()
    private var feedRepository: FeedRepositoryProtocol = Resolver.resolve()
    
    override init() {
        isLoggedIn = userRepository.isLoggedIn
        feed = feedRepository.loadFeed()
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
    
    func onLogoutPressed() {
        Task {
            userRepository.logout()
        }
    }
    
}
