//
//  UIViewExtension.swift
//  git-trending-projects
//
//  Created by Argentino Ducret on 11/23/17.
//  Copyright © 2017 wolox. All rights reserved.
//

import UIKit

extension UIView {
    
    class func loadFromNib(bundle: Bundle? = nil) -> UIView {
        let nibName = NSStringFromClass(self).components(separatedBy: ".").last!
        
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
}
