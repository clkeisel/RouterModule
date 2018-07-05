//
//  DemographicViewController.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/14/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class DemographicViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    var demographicModule = AppData.getSharedAppData().demoModule
    var scanModule = AppData.getSharedAppData().scanModules[0]
    var demoContainerVC: DemographicContainerViewController!
    var routerNav: RouterNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        demoContainerVC = self.childViewControllers[0] as! DemographicContainerViewController
        demoContainerVC.currentDemographic = demographicModule?.next()
        
        routerNav = self.navigationController as? RouterNavigationController
        
        if let pages = demographicModule?.navQueue.count {
            pageControl.numberOfPages = pages
        }
        skipButton.isHidden = demographicModule!.isRequired
        
        guard let routerNav = self.navigationController as? RouterNavigationController else {
            print("Demographics expected RouterNavigationController but didn't find one.")
            return
        }
        self.routerNav = routerNav
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let demographics = demographicModule else { return 0 }
        let demographic = demographics.navQueue[demographics.current]
        return demographic.rowTitles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let demographics = demographicModule else { return 0 }
        let demographic = demographics.navQueue[demographics.current]
        return demographic.rowData.count
    }
    
    @IBAction func skip(_ sender: Any) {
        routerNav!.next()
    }
    
    @IBAction func next(_ sender: Any) {
        if pageControl.currentPage + 1 < pageControl.numberOfPages {
            pageControl.currentPage += 1
            backButton.isEnabled = true
            
            // Set the demographic to the next one in the module
            demoContainerVC.currentDemographic = demographicModule?.next()
            demoContainerVC.nextDeomgraphic()
        } else {
            routerNav!.next()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
