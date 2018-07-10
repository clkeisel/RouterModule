//
//  RouterModule.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/14/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class RouterModule: RouterProtocol {
    
    var navQueue = [String]()
    var current: Int = 0
    let navController: UINavigationController
    private let storyboard: UIStoryboard
    private var rootIdentifier: String!
    
    init(navController: UINavigationController) {
        self.navController = navController
        self.storyboard = navController.storyboard!
    }
    
    func setRootViewController(rootViewControllerIdentity: String) {
        guard let root = self.navController.storyboard?.instantiateViewController(withIdentifier: rootViewControllerIdentity) else {
            print("Unable to instantiate view controller with storyboard ID \(rootViewControllerIdentity)")
            return
        }
        self.rootIdentifier = rootViewControllerIdentity
        self.navController.viewControllers = [root]
    }
    
    func hasNext() -> Bool {
        return current + 1 < navQueue.count
    }
    
    func hasPrevious() -> Bool {
        return current > 0
    }
    
    func next() {
        if hasNext() {
            current += 1
            let vc = storyboard.instantiateViewController(withIdentifier: navQueue[current])
            navController.pushViewController(vc, animated: true)
        } else {
            // Reset the navController to root
            self.navController.viewControllers = []
            self.setRootViewController(rootViewControllerIdentity: rootIdentifier)
            current = 0
            navController.dismiss(animated: true, completion: nil)
        }
    }
    
    func previous() {
        if hasPrevious() {
            current -= 1
            navController.popViewController(animated: true)
        } else {
            navController.dismiss(animated: true, completion: nil)
        }
    }
}
