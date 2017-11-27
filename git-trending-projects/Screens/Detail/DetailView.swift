//
//  DetailView.swift
//  git-trending-projects
//
//  Created by Argentino Ducret on 11/27/17.
//  Copyright © 2017 wolox. All rights reserved.
//

import Foundation
import UIKit

class DetailView: UIView {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var readmeLabel: UILabel!
    @IBOutlet weak var readme: UILabel!
    @IBOutlet weak var centerContainer: UIView!
    @IBOutlet weak var centerLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAppearence()
    }
    
}

// MARK: - Private Methods
private extension DetailView {
    
    func setAppearence() {
        centerContainer.layer.cornerRadius = 5
        centerContainer.layer.borderWidth = 1
        centerContainer.layer.borderColor = UIColor.gray.cgColor
        centerLine.backgroundColor = UIColor.gray
    }
    
}
