//
//  CartTableViewCell.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/23/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit

protocol CartTableViewCellDelegate: class {
    func stepperValueChanged(_ cell: UITableViewCell, sender: UIStepper)
}

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    weak var delegate: CartTableViewCellDelegate?
    var number = 1
        
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberLabel.text = Int(sender.value).description
        number = Int(sender.value)
        delegate?.stepperValueChanged(self, sender: sender)
    }
    
}
