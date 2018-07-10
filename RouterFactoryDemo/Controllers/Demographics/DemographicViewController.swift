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
    
    var demographicModule = AppData.sharedAppData.demoModule!
    var router: RouterModule!
    var demoContainerVC: DemographicContainerViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        demoContainerVC = self.childViewControllers[0] as! DemographicContainerViewController
        demoContainerVC.currentDemographic = demographicModule.navQueue[0]
        
        pageControl.numberOfPages = demographicModule.navQueue.count
        
        skipButton.isHidden = demographicModule.isRequired
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        router = AppData.sharedAppData.currentScanRouter
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        let demographic = demographicModule.navQueue[demographicModule.current]
        return demographic.rowTitles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let demographic = demographicModule.navQueue[demographicModule.current]
        return demographic.rowData.count
    }
    
    @IBAction func skip(_ sender: Any) {
        router.next()
    }
    
    @IBAction func next(_ sender: Any) {
        if pageControl.currentPage + 1 < pageControl.numberOfPages {
            pageControl.currentPage += 1
            
            // Set the demographic to the next one in the module
            demographicModule.next()
            demoContainerVC.currentDemographic = demographicModule.navQueue[demographicModule.current]
            demoContainerVC.nextDeomgraphic()
        } else {
            router.next()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        if pageControl.currentPage - 1 > 0 {
            pageControl.currentPage -= 1
            
            demographicModule.previous()
            demoContainerVC.currentDemographic = demographicModule.navQueue[demographicModule.current]
            demoContainerVC.nextDeomgraphic()
        } else {
            router.previous()
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
