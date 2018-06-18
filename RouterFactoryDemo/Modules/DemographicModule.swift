//
//  DemographicModule.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/14/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class DemographicModule: ModuleProtocol, RouterProtocol {
    var name: String
    var details: String
    var icon: UIImage
    var current: Int
    var navQueue: [Any] = [Demographic]()
    var getEntryPoint: String?
    var router: RouterModule?
    var isRequired: Bool
    
    init(withName name:String, details:String, icon:UIImage, demoQuestions:[Demographic], required:Bool) {
        self.name = name
        self.details = details
        self.icon = icon
        self.navQueue = demoQuestions
        current = 0
        getEntryPoint = "demographicSegue"
        isRequired = required
    }
}
