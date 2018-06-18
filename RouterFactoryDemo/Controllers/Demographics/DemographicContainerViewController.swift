//
//  DemographicContainerViewController.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/15/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class DemographicContainerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var demoName: UILabel!
    @IBOutlet weak var demoPicker: UIPickerView!
    
    var currentDemographic: Demographic!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        demoPicker.delegate = self
        demoPicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        demoName.text = currentDemographic.demoName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextDeomgraphic() {
        demoName.text = currentDemographic.demoName
        demoPicker.reloadAllComponents()
        self.view.setNeedsDisplay()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return currentDemographic.rowTitles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentDemographic.rowData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currentDemographic.rowData[component][row]
    }

}
