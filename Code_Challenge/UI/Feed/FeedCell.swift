//
//  FeedCell.swift
//  Code_Challenge
//
//  Created by Stefan Nestorov on 19.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var feedTitleLabel: UILabel!
    @IBOutlet weak var feedContentLabel: UILabel!
    
    var tweet: Tweet? {
        didSet{
            feedTitleLabel.text = tweet?.user
            feedContentLabel.text = tweet?.content
        }
    }

}
