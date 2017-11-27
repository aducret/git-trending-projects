//
//  Repositorie.swift
//  git-trending-projects
//
//  Created by Argentino Ducret on 11/27/17.
//  Copyright © 2017 wolox. All rights reserved.
//

import Foundation

struct Repository {
    
    let owner: String
    let avatar: URL
    let name: String
    let stars: Int
    let forks: Int
    let description: String
    let fullName: String
    
    var readme: String? = .none
    
    init(owner: String, avatar: URL, fullName: String, name: String, stars: Int, forks: Int, description: String, readme: String? = .none) {
        self.owner = owner
        self.avatar = avatar
        self.name = name
        self.stars = stars
        self.forks = forks
        self.description = description
        self.readme = readme
        self.fullName = fullName
    }
    
    mutating func updateReadme(readme: String) {
        self.readme = readme
    }
    
}
