//
//  Extensions.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 28/08/24.
//

import Foundation
import UIKit


extension String {
    static let empty = ""
}

extension Int {
    static let zero = 0
    static let one = 1
}

extension CGFloat {
    static let ten = 10.0
    static let fourteen = 14.0
    static let sixteen = 16.0
    static let twenty = 20.0
    static let thirty = 30.0
}

extension UIColor {
    static var accentColor: UIColor {
        UIColor(named: AppConstants.ColorName.accent) ?? .blue
    }
    
    static var titleColor: UIColor {
        UIColor(named: AppConstants.ColorName.title) ?? .blue
    }
    
    static var contentColor: UIColor {
        UIColor(named: AppConstants.ColorName.content) ?? .blue
    }
}

extension UIStoryboard {
    static func main() -> UIStoryboard {
        UIStoryboard.init(name: AppConstants.StoryboardName.main, bundle: nil)
    }
    
    static func screenController<T: UIViewController>(storyboardId: String) -> T? {
        UIStoryboard.main().instantiateViewController(withIdentifier: storyboardId) as? T
    }
}
