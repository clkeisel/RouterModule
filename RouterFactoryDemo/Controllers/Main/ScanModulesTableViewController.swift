//
//  ScanModulesTableViewController.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/15/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

class ScanModulesTableViewController: UITableViewController {
    
    let appData = AppData.getSharedAppData()
    var selectedRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.scanModules.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ScanModuleTableViewCell

        // Configure the cell...
        let module = appData.scanModules[indexPath.row]
        cell.moduleNameLabel?.text = module.name
        cell.moduleDescriptionLabel?.text = module.details
        cell.moduleIcon.image = module.icon

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        let vc = appData.scanModules[selectedRow].router
        present(vc!, animated: true, completion: nil)
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
