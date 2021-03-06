//
//  AuthenticationCoordinator.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit

class AuthenticationCoordinator {
    
    static var STORYBOARD_NAME: String = "Authentication"
    
    var postsFeedCoordinator: PostsFeedCoordinator?
    var overviewCoordinator: OverviewCoordinator?
    var profileCoordinator: ProfileCoordinator?
        
    var navController: UINavigationController?
        
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        do {
            if let user = try CredentialsStorage.storage.fetchUser() {
                UserManager.shared.currentUser = user
                JournalManager.shared.fetchCoreData()
                self.pushTabBarController(fetchNeeded: false)
                return
            }
        } catch let err {
            print("- failed to fetch last logged in user: \(err)")
        }
        
        self.pushViewController()
    }
    
    func pushViewController() {
        let vc = ViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        self.navController!.pushViewController(vc, animated: true)
    }
    
    func pushLoginViewController() {
        let vc = LoginViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        self.navController!.pushViewController(vc, animated: true)
    }
    
    func pushSignUpViewController() {
        let vc = SignUpViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        self.navController!.pushViewController(vc, animated: true)
    }
    
    func pushTabBarController(fetchNeeded: Bool) {
        let tabBarController = UITabBarController()
        
        self.postsFeedCoordinator = PostsFeedCoordinator()
        self.postsFeedCoordinator!.start()
        let navControllerPostsFeed = self.postsFeedCoordinator!.navController!
        navControllerPostsFeed.title = "Feed"

        self.overviewCoordinator = OverviewCoordinator()
        self.overviewCoordinator!.start()
        let navControllerOverview = self.overviewCoordinator!.navController!
        navControllerOverview.title = "Overview"

        self.profileCoordinator = ProfileCoordinator()
        self.profileCoordinator!.popToViewControllerHandler = { [weak self] in
            if let _ = self {
                let vc = ViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
                vc.coordinator = self
                self!.navController!.setViewControllers([vc], animated: true)
                self!.navController!.isNavigationBarHidden = false
            }
        }
        self.profileCoordinator!.start()
        let navControllerProfile = self.profileCoordinator!.navController!
        navControllerProfile.title = "Profile"

        tabBarController.setViewControllers([navControllerPostsFeed, navControllerOverview, navControllerProfile], animated: true)
        tabBarController.selectedIndex = 1

        let imageNames: [String] = ["globe", "house", "person"]

        guard let items = tabBarController.tabBar.items else { return }

        for (i, item) in items.enumerated() {
            item.image = UIImage(systemName: imageNames[i])
        }

        if fetchNeeded {
            // fetch followed users for current user if they exist (they definitely should)
            if let currentUser = UserManager.shared.currentUser {
                JournalManager.shared.fetchFirestore(completion: { [weak self] in
                    UserManager.shared.fetchFollowing(forUser: currentUser, saveUser: false, postFetcher: {
                        // fetch posts
                        FeedPostManager.shared.fetchAllPosts()
                    })
                    self!.navController!.pushViewController(tabBarController, animated: true)
                    self!.navController!.isNavigationBarHidden = true
                })
                
            }
        }
        else {
            FeedPostManager.shared.fetchAllPosts()
            self.navController!.pushViewController(tabBarController, animated: true)
            self.navController!.isNavigationBarHidden = true
        }
        
    }
    
}
