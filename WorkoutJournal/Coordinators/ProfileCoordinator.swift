//
//  ProfileCoordinator.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 14.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


public class ProfileCoordinator {
    
    static var STORYBOARD_NAME: String = "Profile"
    
    var navController: UINavigationController?
    
    var popToViewControllerHandler: (() -> ())?
    
    init() {
    }
    
    func start() {
        let vc = ProfileViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        self.navController = UINavigationController(rootViewController: vc)
    }
    
    func pushStatsViewController() {
        let vc = StatsViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        self.navController!.pushViewController(vc, animated: true)
    }
    
    func pushAchievementsViewController() {
        let vc = AchievementsViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        self.navController!.pushViewController(vc, animated: true)
    }
    
    func popToViewController() {
        self.popToViewControllerHandler!()
    }
    
    func pushFollowedUsersViewController() {
        let vc = FollowedUsersViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        self.navController!.pushViewController(vc, animated: true)
    }
        
}
