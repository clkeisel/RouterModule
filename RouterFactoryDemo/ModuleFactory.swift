//
//  ModuleFactory.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/12/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class ModuleFactory: NSObject {
    
    //MARK: - Fields
    
    static let sharedFactory = ModuleFactory()
    
    var market: String
    
    var demoModule: DemographicModule!

    let handScanIcon = UIImage(named: "ConvertIcon")!
    let handScan = "HAND SCAN"
    let handScanDesc = "FIND OUT YOUR SKIN CAROTENOID SCORE"
    let demoScanIcon = UIImage(named: "ConvertIcon")!
    let demoScanName = "DEMO SCAN"
    let demoScanDesc = "FIND OUT YOUR SCORE BEFORE SIGNING UP."
    let thvScanIcon = UIImage(named: "ConvertIcon")!
    let thvScanName = "THV SCAN"
    let thvScanDesc = "AVERAGE 3 SCORES TO GET CLOSER TO YOUR THV"
    let demographicIcon = UIImage(named: "MapIcon")!
    let demographicName = "DEMOGRAPHICS"
    let demographicDesc = "TELL US ABOUT YOURSELF FOR SPECIAL FEATURES AND TO EARN DISCOUNTS."
    
    enum ModuleFactoryError: Error {
        case invalidInitialControllerForRouter
    }
    
    //MARK: - Routers
    var handScanRouter: RouterModule!
    var demoScanRouter: RouterModule!
    var thvScanRouter: RouterModule!
    
    //MARK: - Factory Functions
    private override init() {
        self.demoModule = DemographicModule()
        self.market = ""
        super.init()
    }
    
    func buildModulesForMarket(market: String) {
        self.market = market
        do {
            buildDemographicsModule()
            try buildRouterModules()
            buildScanModules()
        } catch ModuleFactoryError.invalidInitialControllerForRouter {
            print("Unable to build Scan Modules because the initial view controller of a module must be a UINavigationController")
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
}

// MARK: scan module factory method
extension ModuleFactory {
    private func buildScanModules() {
        var scanModules = [ScanModule]()
        
        switch market {
        case "North America":
            scanModules.append(ScanModule(withName: handScan, description: handScanDesc, icon: handScanIcon, router: handScanRouter))
            scanModules.append(ScanModule(withName: demoScanName, description: demoScanDesc, icon: demoScanIcon, router: demoScanRouter))
        case "Germany":
            scanModules.append(ScanModule(withName: handScan, description: handScanDesc, icon: handScanIcon, router: handScanRouter))
            scanModules.append(ScanModule(withName: demoScanName, description: demoScanDesc, icon: demoScanIcon, router: demoScanRouter))
            scanModules.append(ScanModule(withName: thvScanName, description: thvScanDesc, icon: thvScanIcon, router: thvScanRouter))
        case "China":
            scanModules.append(ScanModule(withName: handScan, description: handScanDesc, icon: handScanIcon, router: handScanRouter))
            scanModules.append(ScanModule(withName: thvScanName, description: thvScanDesc, icon: thvScanIcon, router: thvScanRouter))
        default:
            scanModules.append(ScanModule(withName: handScan, description: handScanDesc, icon: handScanIcon, router: handScanRouter))
            scanModules.append(ScanModule(withName: demoScanName, description: demoScanDesc, icon: demoScanIcon, router: demoScanRouter))
        }
        AppData.sharedAppData.scanModules = scanModules
    }
}

// MARK: demographic module factory method
extension ModuleFactory {
    private func buildDemographicsModule() {
        var demographics = [Demographic]()
        var required = false
        
        // Build demographics
        var feet = [String]()
        var inches = [String]()
        var centimeters = [String]()
        var pounds = [String]()
        var kilos = [String]()
        
        for foot in 0..<8 { feet.append(String(foot) + "feet") }
        for inch in 0..<12 { inches.append(String(inch) + "inches") }
        for centimeter in 0..<100 { centimeters.append(String(centimeter) + " cm") }
        for pound in 1...500 { pounds.append(String(pound) + "lb") }
        for kilo in 1...250 { kilos.append(String(kilo) + "kg") }
    
        let imperialHeight = Demographic(withDemoName: "Height", rowData: [feet, inches], rowTitles: ["Feet", "Inches"], icon: demographicIcon)
        let metricHeight = Demographic(withDemoName: "Height", rowData: [["0 m", "1 m", "2 m"], centimeters], rowTitles: ["Meters", "Centimeters"], icon: demographicIcon)
        let ethnicity = Demographic(withDemoName: "Ethnicity", rowData: [["Hispanic", "African American", "Asian", "Caucasian", "Middle Eastern", "Native American", "Pacific Islander"]], rowTitles: ["Ethnicity"], icon: demographicIcon)
        let imperialWeight = Demographic(withDemoName: "Weight", rowData: [pounds], rowTitles: ["Pounds"], icon: demographicIcon)
        let metricWeight = Demographic(withDemoName: "Weight", rowData: [kilos], rowTitles: ["Kilograms"], icon: demographicIcon)
        let supplementation = Demographic(withDemoName: "Supplements", rowData: [["Never", "Inconsistent", "Consistent"]], rowTitles: ["Supplementation"], icon: demographicIcon)
        let taiChi = Demographic(withDemoName: "Tai Chi", rowData: [["Never", "Inconsistent", "Morning", "Morning & Evening"]], rowTitles: ["Frequency"], icon: demographicIcon)
        let fruitsVeggies = Demographic(withDemoName: "Fruit/Veggie Consumption", rowData: [["0-1 servings per day", "2-3 servings per day", "4 or more servings per day"]], rowTitles: ["Servings"], icon: demographicIcon)
        let gender = Demographic(withDemoName: "Gender", rowData: [["Male", "Female"]], rowTitles: ["Gender"], icon: demographicIcon)
        
        switch market {
        case "North America":
            demographics = [imperialHeight, imperialWeight, ethnicity, fruitsVeggies]
        case "Germany":
            demographics = [metricHeight, metricWeight, supplementation, gender]
        case "China":
            demographics = [metricHeight, metricWeight, taiChi, supplementation]
            required = true
        default:
            demographics = [metricHeight, metricWeight, supplementation, fruitsVeggies]
        }
        AppData.sharedAppData.demoModule = DemographicModule(withName: demographicName,
                                            details: demographicDesc,
                                            icon: demographicIcon,
                                            demoQuestions: demographics,
                                            required: required)
    }
}

// MARK: router module factory method
extension ModuleFactory {
    private func buildRouterModules() throws {
        let storyboard = UIStoryboard(name: "Scan", bundle: nil)
        guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController else {
            throw ModuleFactoryError.invalidInitialControllerForRouter
        }
        handScanRouter = RouterModule(navController: navController)
        demoScanRouter = RouterModule(navController: navController)
        thvScanRouter = RouterModule(navController: navController)
        switch market {
        case "North America":
            handScanRouter.navQueue = ["ScanProcess"]
            demoScanRouter.navQueue = ["ScanProcess"]
            handScanRouter.setRootViewController(rootViewControllerIdentity: handScanRouter.navQueue[0])
            demoScanRouter.setRootViewController(rootViewControllerIdentity: demoScanRouter.navQueue[0])
        case "Germany":
            handScanRouter.navQueue = ["ScanProcess", "Demographics"]
            demoScanRouter.navQueue = ["ScanProcess", "Demographics"]
            thvScanRouter.navQueue = ["ScanProcess", "Demographics"]
            handScanRouter.setRootViewController(rootViewControllerIdentity: handScanRouter.navQueue[0])
            demoScanRouter.setRootViewController(rootViewControllerIdentity: demoScanRouter.navQueue[0])
            thvScanRouter.setRootViewController(rootViewControllerIdentity: thvScanRouter.navQueue[0])
        case "China":
            handScanRouter.navQueue = ["Demographics", "ScanProcess"]
            thvScanRouter.navQueue = ["Demographics", "ScanProcess"]
            handScanRouter.setRootViewController(rootViewControllerIdentity: handScanRouter.navQueue[0])
            thvScanRouter.setRootViewController(rootViewControllerIdentity: thvScanRouter.navQueue[0])
        default:
            handScanRouter.navQueue = ["ScanProcess"]
            demoScanRouter.navQueue = ["ScanProcess"]
            handScanRouter.setRootViewController(rootViewControllerIdentity: handScanRouter.navQueue[0])
            demoScanRouter.setRootViewController(rootViewControllerIdentity: demoScanRouter.navQueue[0])
        }
    }
}

//extension ModuleFactory {
//    private func buildRouterNavControllers() throws {
//        let storyboard = UIStoryboard(name: "Scan", bundle: nil)
//        guard let navRouter = storyboard.instantiateViewController(withIdentifier: "ScanNav") as? RouterNavigationController else {
//            let error = NSError(domain: "ModuleFactory", code: 1, userInfo: ["Message": "Could not instantiate Router from storyboard \(storyboard)"])
//            throw error
//        }
//        switch scanOperator?.market {
//        case "North America":
//            navRouter.navQueue = ["ScanProcess"]
//        case "Germany":
//            navRouter.navQueue = ["ScanProcess", "Demographics"]
//        case "China":
//            navRouter.navQueue = ["Demographics", "ScanProcess"]
//        default:
//            navRouter.navQueue = ["ScanProcess"]
//        }
//        scanRouter = navRouter
//    }
//}
