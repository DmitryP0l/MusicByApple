//
//  MainTabBarController.swift
//  MusicByApple
//
//  Created by lion on 10.06.22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setControllers()        
    }
    
    private func setControllers() {
        viewControllers = [ generateViewController(rootVC: searchVC,
                                                   image: UIImage(systemName: "magnifyingglass")!, title: "Search"),
                            generateViewController(rootVC: ViewController(),
                                                   image: UIImage(systemName: "music.note.list")!, title: "Library")
        ]
    }
    
    private func generateViewController(rootVC: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootVC.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        tabBar.tintColor = .systemPink
        return navigationVC
    }
    
}
