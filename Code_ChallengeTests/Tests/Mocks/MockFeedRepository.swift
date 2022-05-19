//
//  MockFeedRepository.swift
//  Code_ChallengeTests
//
//  Created by Stefan Nestorov on 19.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import Foundation
@testable import Code_Challenge

class MockFeedRepository: FeedRepositoryProtocol {
    
    func loadFeed() -> [Tweet] {
        return [Tweet(id: 1, content: "mock content", user: "mock user")]
    }
    
}
