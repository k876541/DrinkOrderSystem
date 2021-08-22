//
//  CartTableViewCell.swift
//  DrinkOrderSystem
//
//  Created by Ryan Chang on 2021/5/20.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var plusLabel: UILabel!
    @IBOutlet weak var orderName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
