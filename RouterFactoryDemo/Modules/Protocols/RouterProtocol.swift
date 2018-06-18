//
//  RouterProtocol.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/13/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

protocol RouterProtocol {
    var navQueue: [Any] { get set }
    var current: Int { get set }
}

// Default implementation for navigating the navQueue
extension RouterProtocol {
    func hasNext() -> Bool {
        return current < navQueue.count
    }
    
    func hasPrevious() -> Bool {
        return current > 0
    }
    
    mutating func next() -> Any? {
        if hasNext() {
            current += 1
            return navQueue[current - 1]
        } else {
            return nil
        }
    }
    
    mutating func previous() -> Any? {
        if hasPrevious() {
            current -= 1
            return navQueue[current + 1]
        } else {
            return nil
        }
    }
}

