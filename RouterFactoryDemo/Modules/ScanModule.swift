//
//  ScanModule.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/13/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class ScanModule: ModuleProtocol{
    
    var name: String
    var details: String
    var icon: UIImage
    var router: RouterModule
    
    init(withName name:String, description:String, icon:UIImage, router:RouterModule ) {
        self.name = name
        self.details = name
        self.icon = icon
        self.router = router
    }
}
