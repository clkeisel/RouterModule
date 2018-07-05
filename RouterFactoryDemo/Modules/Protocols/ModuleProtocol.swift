//
//  ModuleProtocol.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/12/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

// Module protocol factory fields
protocol ModuleProtocol {
    var name: String { get }
    var details: String { get }
    var icon: UIImage { get }
}
