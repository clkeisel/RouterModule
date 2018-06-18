//
//  Demographic.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/14/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class Demographic {
    
    let sections: Int
    let rowData: [[String]]
    let rowTitles: [String]
    let demoIcon: UIImage
    let demoName: String
    
    init(withDemoName name:String, rowData:[[String]], rowTitles:[String], icon:UIImage) {
        self.demoName = name
        self.rowData = rowData
        self.rowTitles = rowTitles
        self.demoIcon = icon
        sections = rowTitles.count
    }
}
