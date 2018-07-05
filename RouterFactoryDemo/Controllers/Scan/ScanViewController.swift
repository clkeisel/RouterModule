//
//  ScanViewController.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/13/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class ScanViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var values = [Int]()
    var scanModule = AppData.getSharedAppData().scanModules[0]

    @IBOutlet weak var scanScorePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for value in 1...100000 {
            values.append(value)
        }
        
        scanScorePickerView.dataSource = self
        scanScorePickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row].description
    }
    
    @IBAction func startScan(_ sender: Any) {
        let randomScore = (Int)(arc4random_uniform(99999) + 1)
        scanScorePickerView.selectRow(randomScore, inComponent: 0, animated: true)
    }
    
    @IBAction func done(_ sender: Any) {
        guard let router = self.navigationController as? RouterNavigationController else {
            print("Scan View Controller expected a RouterNavigationController, but wasn't found.")
            return
        }
        router.next()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
