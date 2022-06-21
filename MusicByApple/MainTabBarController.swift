//
//  MainTabBarController.swift
//  MusicByApple
//
//  Created by lion on 10.06.22.
//

import UIKit

protocol MainTabBarControllerDelegate: AnyObject {
    func minimizeTrackDetailController()
}

final class MainTabBarController: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    
    private var minTopAnchorConstraint: NSLayoutConstraint!
    private var maxTopAnchorConstraint: NSLayoutConstraint!
    private var bottomAnchorConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setControllers()
        setupTrackDetailView()
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
    
    private func setupTrackDetailView() {
        let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
        trackDetailView.backgroundColor = .green
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchVC
        maxTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor)
        minTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        maxTopAnchorConstraint.isActive = true
        bottomAnchorConstraint.isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
    }
}

extension MainTabBarController: MainTabBarControllerDelegate {
    
    func minimizeTrackDetailController() {
        
        maxTopAnchorConstraint.isActive = false
        minTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: { self.view.layoutIfNeeded() },
                       completion: nil)
    }
    
    
}
