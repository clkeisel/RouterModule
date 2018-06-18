//
//  ModuleFactory.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/12/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class ModuleFactory: NSObject {
    
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
    
    // MARK: Routers
    var scanRouter: RouterModule?

    var scanOperator: ScanOperator? {
        didSet {
            // Router modules must be built first as other modules are dependent on them
            buildRouterModules()
            buildScanModules()
            buildDemographicsModule()
        }
    }
    
    static var sharedFactory = ModuleFactory()
    
    private override init() {
        scanRouter = nil
        super.init()
    }
    
}

// MARK: scan module factory method
extension ModuleFactory {
    private func buildScanModules() {
        var scanModules = [ScanModule]()
        switch scanOperator?.market {
        case "North America":
            scanModules.append(ScanModule(withName: handScan, description: handScanDesc, icon: handScanIcon, router: scanRouter!))
            scanModules.append(ScanModule(withName: demoScanName, description: demoScanDesc, icon: demoScanIcon, router: scanRouter!))
        case "Germany":
            scanModules.append(ScanModule(withName: handScan, description: handScanDesc, icon: handScanIcon, router: scanRouter!))
            scanModules.append(ScanModule(withName: demoScanName, description: demoScanDesc, icon: demoScanIcon, router: scanRouter!))
            scanModules.append(ScanModule(withName: thvScanName, description: thvScanDesc, icon: thvScanIcon, router: scanRouter!))
        case "China":
            scanModules.append(ScanModule(withName: handScan, description: handScanDesc, icon: handScanIcon, router: scanRouter!))
            scanModules.append(ScanModule(withName: thvScanName, description: thvScanDesc, icon: thvScanIcon, router: scanRouter!))
        default:
            scanModules.append(ScanModule(withName: handScan, description: handScanDesc, icon: handScanIcon, router: scanRouter!))
            scanModules.append(ScanModule(withName: demoScanName, description: demoScanDesc, icon: demoScanIcon, router: scanRouter!))
            scanModules.append(ScanModule(withName: thvScanName, description: thvScanDesc, icon: thvScanIcon, router: scanRouter!))
        }
        AppData.getSharedAppData().scanModules = scanModules
    }
}

// MARK: demographic module factory method
extension ModuleFactory {
    private func buildDemographicsModule() {
        var demographics = [Demographic]()
        
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
        
        switch scanOperator?.market {
        case "North America":
            demographics = [imperialHeight, imperialWeight, ethnicity, fruitsVeggies]
            AppData.getSharedAppData().demoModule = DemographicModule(withName: demographicName,
                                                                      details: demographicDesc,
                                                                      icon: demographicIcon,
                                                                      demoQuestions: demographics,
                                                                      required: false)
        case "Germany":
            demographics = [metricHeight, metricWeight, supplementation, gender]
            AppData.getSharedAppData().demoModule = DemographicModule(withName: demographicName,
                                                                      details: demographicDesc,
                                                                      icon: demographicIcon,
                                                                      demoQuestions: demographics,
                                                                      required: false)
        case "China":
            demographics = [metricHeight, metricWeight, taiChi, supplementation]
            AppData.getSharedAppData().demoModule = DemographicModule(withName: demographicName,
                                                                      details: demographicDesc,
                                                                      icon: demographicIcon,
                                                                      demoQuestions: demographics,
                                                                      required: true)
        default:
            demographics = [metricHeight, metricWeight, supplementation, fruitsVeggies]
            AppData.getSharedAppData().demoModule = DemographicModule(withName: demographicName,
                                                                      details: demographicDesc,
                                                                      icon: demographicIcon,
                                                                      demoQuestions: demographics,
                                                                      required: false)
        }
    }
}

// MARK: router module factory method
extension ModuleFactory {
    private func buildRouterModules() {
        switch scanOperator?.market {
        case "North America":
            scanRouter = RouterModule(withNavQueue: ["scanSegue"])
        case "Germany":
            scanRouter = RouterModule(withNavQueue: ["scanSegue", "demographicSegue"])
        case "China":
            scanRouter = RouterModule(withNavQueue: ["demographicSegue", "scanSegue"])
        default:
            scanRouter = RouterModule(withNavQueue: ["scanSegue"])
        }
    }
}
