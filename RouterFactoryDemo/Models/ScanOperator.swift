//
//  ScanOperator.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/12/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class ScanOperator: NSObject {

    var market: String!
    
    init(withMarket market:String) {
        self.market = market
    }
}
