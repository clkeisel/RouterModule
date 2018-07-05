//
//  DemographicModule.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/14/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class DemographicModule<demographic: Demographic>: ModuleProtocol, RouterProtocol {
    typealias T = demographic
    
    var name: String
    var details: String
    var icon: UIImage
    var current: Int
    
    var navQueue = [demographic]()
    var getEntryPoint: String?
    var isRequired: Bool
    
    init(withName name:String, details:String, icon:UIImage, demoQuestions:[demographic], required:Bool) {
        self.name = name
        self.details = details
        self.icon = icon
        self.navQueue = demoQuestions
        current = 0
        getEntryPoint = "demographicSegue"
        isRequired = required
    }
    
    func hasNext() -> Bool {
        return current < navQueue.count
    }
    
    func hasPrevious() -> Bool {
        return current > 0
    }
    
    func next() -> demographic? {
        if hasNext() {
            current += 1
            return navQueue[current - 1]
        } else {
            return nil
        }
    }
    
    func previous() -> demographic? {
        if hasPrevious() {
            current -= 1
            return navQueue[current - 1]
        } else {
            return nil
        }
    }
}
