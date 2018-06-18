//
//  RouterModule.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/14/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class RouterModule: RouterProtocol {
    
    var navQueue: [Any] = [Any]()
    var current: Int
    
    init(withNavQueue navQueue:[Any]) {
        self.navQueue = navQueue
        self.current = 0
    }
}
