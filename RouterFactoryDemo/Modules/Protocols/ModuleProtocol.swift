//
//  ModuleProtocol.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/12/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

// Module protocol factory fields
@objc protocol ModuleProtocol {
    var name: String { get set }
    var details: String { get set }
    var icon: UIImage { get set }
    @objc optional var getEntryPoint: String? { get set }
}
