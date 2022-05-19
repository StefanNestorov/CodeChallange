//
//  CommonProtocols.swift
//  Code_Challenge
//
//  Created by Stefan Nestorov on 18.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import Foundation

protocol UserRepositoryProtocol {
    
    ///The actual wrapped value of the publisher
    var isLoggedIn:Bool { get }
    ///The publisher (you can subscribe to it to receive updates when the value changes)
    var isLoggedInPublisher: Published<Bool>.Publisher { get }
    
    func login(dto: LoginDto)
    func logout()
    
}

protocol AuthServiceProtocol {

    //Optionally we should expose the wrapped value AND the publisher (as in the repository), but for simplicity and because the TwitterClient will update the field synchronously we can use only this field.
    var isLoggedIn:Bool { get }
    
    func login(dto: LoginDto)
    func logout()
    
}

protocol FeedRepositoryProtocol {
    
    func loadFeed() -> [Tweet]
    
}

protocol FeedServiceProtocol {
    
    func loadFeed() -> [Tweet]
    
}
