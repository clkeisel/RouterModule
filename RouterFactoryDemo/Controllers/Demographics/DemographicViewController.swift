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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        demoContainerVC = self.childViewControllers[0] as! DemographicContainerViewController
        demoContainerVC.currentDemographic = demographicModule?.next() as? Demographic
        if let pages = demographicModule?.navQueue.count {
            pageControl.numberOfPages = pages
        }
        skipButton.isHidden = demographicModule!.isRequired
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        guard let demographics = demographicModule else { return 0 }
        let demographic = demographics.navQueue[demographics.current] as? Demographic
        return demographic?.rowTitles.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let demographics = demographicModule else { return 0 }
        let demographic = demographics.navQueue[demographics.current] as? Demographic
        return demographic?.rowData.count ?? 0
    }
    
    @IBAction func skip(_ sender: Any) {
        guard let nextSegueIdentifer = scanModule.router.next() as? String else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        self.performSegue(withIdentifier: nextSegueIdentifer, sender: self)
    }
    
    @IBAction func next(_ sender: Any) {
        if pageControl.currentPage + 1 < pageControl.numberOfPages {
            pageControl.currentPage += 1
            backButton.isEnabled = true
            
            // Set the demographic to the next one in the module
            demoContainerVC.currentDemographic = demographicModule?.next() as? Demographic
            demoContainerVC.nextDeomgraphic()
        } else {
            guard let nextSegueIdentifier = scanModule.router.next() as? String else {
                navigationController?.popToRootViewController(animated: true)
                return
            }
            self.performSegue(withIdentifier: nextSegueIdentifier, sender: self)
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
