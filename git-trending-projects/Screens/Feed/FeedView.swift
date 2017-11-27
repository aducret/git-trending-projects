//
//  FeedView.swift
//  git-trending-projects
//
//  Created by Argentino Ducret on 11/23/17.
//  Copyright © 2017 wolox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

class FeedView: UIView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setSearchBarAppearence()
    }
    
}

private extension FeedView {
    
    func setSearchBarAppearence() {
        searchBar.placeholder = "Search"
    }
    
}
