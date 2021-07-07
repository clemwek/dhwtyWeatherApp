//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by DHwty on 07/07/2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLable: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var daysTemp: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
