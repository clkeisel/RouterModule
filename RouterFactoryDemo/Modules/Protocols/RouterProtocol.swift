//
//  RouterProtocol.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/13/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import Foundation

protocol RouterProtocol {
    func hasNext() -> Bool
    func hasPrevious() -> Bool
    mutating func next()
    mutating func previous()
}

