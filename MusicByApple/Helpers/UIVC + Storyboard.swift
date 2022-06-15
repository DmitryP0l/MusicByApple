//
//  UIVC + Storyboard.swift
//  MusicByApple
//
//  Created by lion on 14.06.22.
//

import UIKit

extension UIViewController {
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("error in \(name) storyboard")
        }
    }
}
