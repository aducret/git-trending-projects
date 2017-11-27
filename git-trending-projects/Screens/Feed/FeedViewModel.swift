//
//  FeedViewMOdel.swift
//  git-trending-projects
//
//  Created by Argentino Ducret on 11/23/17.
//  Copyright © 2017 wolox. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire

class FeedViewModel {
    
    let repositories: Property<[Repository]>
    var count: Int {
        return repositories.value.count
    }
    
    private let _searchBarText = MutableProperty<String>("");
    private let _repositories = MutableProperty<[Repository]>([]);
    private var _allRepositories: [Repository] = []
    
    init() {
        self.repositories = Property(_repositories)
        
        fetchRepositories()
        
        _searchBarText.signal.observeValues { [unowned self] text in
            if text.count == 0 {
                self._repositories.value = self._allRepositories
                return
            }
            
            self._repositories.value = self._allRepositories.filter { $0.name.lowercased().contains(text.lowercased())}
            print(self._repositories.value)
        }
    }
    
    func setSearchBarText(text: String) {
        _searchBarText.value = text
    }
    
    subscript(index: Int) -> Repository {
        get {
            return _repositories.value[index]
        }
    }
    
}

// Mark: - Private Methods
private extension FeedViewModel {
    
    func getDaysAgo(_ daysAgo: TimeInterval) -> String {
        let date = Date()
        let sevenDaysAgo = date.addingTimeInterval(-daysAgo * 24 * 60 * 60)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: sevenDaysAgo)
    }
    
    func fetchRepositories() {
        let parameters: [String : Any] = [
            "sort" : "stars",
            "order" : "desc",
            "q" : "created:\(getDaysAgo(7))"
        ]
        
        Alamofire
            .request("https://api.github.com/search/repositories", parameters: parameters)
            .responseJSON { response in
                if let json = response.result.value as? [String : Any] {
                    let a = json["items"] as! [[String : Any]]
                    let repositories = a.map { (item: [String : Any]) -> Repository in
                        let owner = item["owner"] as! [String : Any]
                        return Repository(
                            owner: owner["login"]! as! String,
                            avatar: URL(string: owner["avatar_url"]! as! String)!,
                            fullName: item["full_name"]! as! String,
                            name: item["name"]! as! String,
                            stars: item["stargazers_count"] as! Int,
                            forks: item["forks_count"] as! Int,
                            description: item["description"] as? String ?? ""
                        )
                    }
                    self._repositories.value = repositories
                    self._allRepositories = repositories
                }
        }
    }
    
}
