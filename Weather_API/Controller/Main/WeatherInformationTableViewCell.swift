//
//  WeatherInformationTableViewCell.swift
//  Weather_API
//
//  Created by 阿瑋 on 2022/10/12.
//

import UIKit

class WeatherInformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var wxlabel: UILabel!
    @IBOutlet weak var templabel: UILabel!
    @IBOutlet weak var cilabel: UILabel!
    @IBOutlet weak var poplabel: UILabel!

    static let identifier = "WeatherInformationTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
