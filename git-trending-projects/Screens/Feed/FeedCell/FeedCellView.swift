//
//  FeedCellView.swift
//  git-trending-projects
//
//  Created by Argentino Ducret on 11/27/17.
//  Copyright © 2017 wolox. All rights reserved.
//

import Foundation
import UIKit

class FeedCellView: UITableViewCell {
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectStarsLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UILabel!
    
    init(reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
