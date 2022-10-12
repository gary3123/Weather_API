//
//  place_cell.swift
//  Weather_API
//
//  Created by 阿瑋 on 2022/9/28.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var place_label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
