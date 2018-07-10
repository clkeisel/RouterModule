//
//  AppData.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/13/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import Foundation

class AppData {
    
    var scanModules = [ScanModule]()
    var demoModule: DemographicModule!
    var currentScanRouter: RouterModule!
    static let sharedAppData = AppData()
    
    private init() {}
    
    func setScanRouter(moduleName: String) {
        switch moduleName {
        case "HAND SCAN":
            currentScanRouter = ModuleFactory.sharedFactory.handScanRouter
        case "DEMO SCAN":
            currentScanRouter = ModuleFactory.sharedFactory.demoScanRouter
        case "THV SCAN":
            currentScanRouter = ModuleFactory.sharedFactory.thvScanRouter
        default:
            currentScanRouter = ModuleFactory.sharedFactory.handScanRouter
        }
    }
}
