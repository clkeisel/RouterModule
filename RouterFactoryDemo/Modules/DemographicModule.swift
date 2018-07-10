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
    
    var navQueue = [Demographic]()
    var getEntryPoint: String?
    var isRequired: Bool
    
    convenience init() {
        let emptyDemo = [Demographic]()
        self.init(withName: "DEMOGRAPHICS", details: "TELL US ABOUT YOURSELF FOR SPECIAL FEATURES AND TO EARN DISCOUNTS.", icon: UIImage(named: "MapIcon")!, demoQuestions: emptyDemo, required: false)
    }
    
    init(withName name:String, details:String, icon:UIImage, demoQuestions:[Demographic], required:Bool) {
        self.name = name
        self.details = details
        self.icon = icon
        self.navQueue = demoQuestions
        current = 0
        getEntryPoint = "demographicSegue"
        isRequired = required
    }
    
    func hasNext() -> Bool {
        return current < navQueue.count - 1
    }
    
    func hasPrevious() -> Bool {
        return current > 0
    }
    
    func next()  {
        if hasNext() {
            current += 1
            
        } else {
            current = 0
        }
    }
    
    func previous() {
        if hasPrevious() {
            current -= 1
            
        } else {
            
        }
    }
}
