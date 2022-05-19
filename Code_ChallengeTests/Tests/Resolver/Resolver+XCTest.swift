//
//  Resolver+XCTest.swift
//  Finder_Tests
//
//  Created by Stefan Nestorov on 27.02.22.
//

import Foundation
@testable import Code_Challenge

extension Resolver {
    // MARK: - Mock Container
    static var mock:Resolver!
    
    // MARK: - Register Mock Services
    static func registerMockServices() {
        
        Resolver.mock = Resolver(child: .main)
        Resolver.root = Resolver.mock
        
        Resolver.mock.register { MockUserRepository() as UserRepositoryProtocol }.scope(.container)
        Resolver.mock.register { MockFeedRepository() as FeedRepositoryProtocol }.scope(.container)
        
    }
}
