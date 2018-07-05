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
    private let navController: UINavigationController
    private let storyboard: UIStoryboard
    
    init(navController: UINavigationController) {
        self.navController = navController
        self.storyboard = navController.storyboard!
    }
    
    func hasNext() -> Bool {
        return current < navQueue.count
    }
    
    func hasPrevious() -> Bool {
        return current > 0
    }
    
    func next() {
        if hasNext() {
            current += 1
            storyboard.instantiateViewController(withIdentifier: navQueue[current - 1])
        } else {
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
