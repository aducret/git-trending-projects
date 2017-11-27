//
//  DetailViewModel.swift
//  git-trending-projects
//
//  Created by Argentino Ducret on 11/27/17.
//  Copyright © 2017 wolox. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift

class DetailViewModel {
    
    var avatarURL: URL {
        return _repository.avatar
    }
    
    let readme: Property<String>
    
    private let _repository: Repository
    private let _readme = MutableProperty<String>("Loading...")
    
    init(repository: Repository) {
        readme = Property(_readme)
        _repository = repository
        
        Alamofire
            .request("https://api.github.com/repos/\(_repository.fullName)/readme")
            .responseJSON { response in
                if let json = response.result.value as? [String : Any] {
                    let readmeString = (json["content"] as! String).replacingOccurrences(of: "\n", with: "")
                    let data = NSData(base64Encoded: readmeString, options: NSData.Base64DecodingOptions(rawValue: 0))
                    let base64Decoded = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
                    if let readme = base64Decoded as String? {
                        self._readme.value = readme
                    }
                }
        }

    }
    
}

// MARK: - Strings
extension DetailViewModel {
    
    var title: String {
        return _repository.name
    }
    
    var stars: String {
        return "\(_repository.stars) Stars"
    }
        
    var forks: String {
        return "\(_repository.forks) Forks"
    }
    
    var username: String {
        return _repository.owner
    }
    
    var description: String {
        return _repository.description
    }
    
}
