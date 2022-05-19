//
//  FeedService.swift
//  Code_Challenge
//
//  Created by Stefan Nestorov on 19.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import Foundation

class FeedService: FeedServiceProtocol {
    
    func loadFeed() -> [Tweet] {
        return TwitterClient.shared.loadTimeline()
    }
    
}
