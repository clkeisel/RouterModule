//
//  RouterNavigationController.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 7/2/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class RouterNavigationController: UINavigationController, NavRouterProtocol {
    // Current starts at 1 because when the Router is pushed on the storyboard it pushes the 0 index on the navQueue as the rootVc
    var current: Int = 0
    var navQueue = [String]() {
        didSet {
            rootIdentifier = navQueue[0]
        }
    }
    var rootIdentifier: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.next()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func hasNext() -> Bool {
        return current < navQueue.count
    }
    
    func hasPrevious() -> Bool {
        return current > 0
    }
    
    func next() {
        if hasNext() {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: navQueue[current]) else {
                // If there isn't a view controller in the navQueue print log and do nothing
                print("No view controller identifier found in the navQueue for \(RouterNavigationController.description())")
                return
            }
            current += 1
            self.pushViewController(vc, animated: true)
        } else {
            // If there isn't a next then we've reached the end of the navQueue and can pop the nav stack.
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func previous() {
        if hasPrevious() {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: navQueue[current]) else {
                // If there isn't a view controller in the navQueue print log and do nothing
                print("No view controller identifier found in the navQueue for \(RouterNavigationController.description())")
                return
            }
            current -= 1
            self.pushViewController(vc, animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
