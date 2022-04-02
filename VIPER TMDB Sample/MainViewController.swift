//
//  MainViewController.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
        updateUserInterface()
        
        self.tabBar.barTintColor  = .black
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.isTranslucent = true
        
        let mostRecentRoute = UINavigationController()
        mostRecentRoute.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        mostRecentRoute.setRootRoute(PopularMoviesWireframe())
        
        let searchRoute = UINavigationController()
        searchRoute.tabBarItem =  UITabBarItem(tabBarSystemItem: .search, tag: 1)
        searchRoute.setRootRoute(SearchMoviesWireframe())
        
        
        self.setViewControllers([mostRecentRoute,searchRoute], animated: true)
        
    }
    
    func updateUserInterface() {
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
}
