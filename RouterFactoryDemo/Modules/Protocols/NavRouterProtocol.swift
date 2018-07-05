//
//  NavRouterProtocol.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 7/2/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import Foundation

protocol NavRouterProtocol {
    var current: Int { get set }
    func hasNext() -> Bool
    func hasPrevious() -> Bool
    mutating func next()
    mutating func previous()
}
