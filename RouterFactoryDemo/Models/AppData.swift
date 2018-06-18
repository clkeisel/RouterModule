//
//  AppData.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/13/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class AppData {
    
    var scanModules = [ScanModule]()
    var demoModule: DemographicModule?
    private static var sharedAppData = AppData()
    
    private init() {}
    
    class func getSharedAppData() -> AppData {
        return sharedAppData
    }
}
