//
//  ScanModuleTableViewCell.swift
//  RouterFactoryDemo
//
//  Created by Clay Keisel on 6/15/18.
//  Copyright © 2018 Patomalo Development. All rights reserved.
//

import UIKit

@IBDesignable class ScanModuleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moduleIcon: UIImageView!
    @IBOutlet weak var moduleNameLabel: UILabel!
    @IBOutlet weak var moduleDescriptionLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add Margins to the content view of the tableViewCell
        let contentFrame = self.contentView.frame
        let frameWithMargins = UIEdgeInsetsInsetRect(contentFrame, UIEdgeInsetsMake(10, 10, 10, 10))
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.blue.cgColor
        self.contentView.frame = frameWithMargins
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
