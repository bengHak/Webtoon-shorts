//
//  MainTabBarViewController.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/04.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    // MARK: - Properties
    private let home = HomeViewController()
    private let shorts = ShortsViewController()
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let homeTab = createNavController(for: home,
                                          title: "Home",
                                          image: UIImage(systemName: "house"),
                                          selectedImage: UIImage(systemName: "house.fill"))

        let shortsTab = createNavController(for: shorts,
                                            title: "Shorts",
                                            image: UIImage(systemName: "film"),
                                            selectedImage: UIImage(systemName: "film.fill"))
        
        self.viewControllers = [homeTab, shortsTab]
    }
    
    // MARK: - Methods
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let navController: UINavigationController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem = UITabBarItem(title: title,
                                                image: image,
                                                selectedImage: selectedImage)
        return navController
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Shorts" {
            tabBar.barTintColor = .black
            tabBar.tintColor = .white
        } else {
            tabBar.barTintColor = .white
            tabBar.tintColor = .black
        }
    }
}
