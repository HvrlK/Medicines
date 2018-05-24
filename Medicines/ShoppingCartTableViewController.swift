//
//  ShoppingCartTableViewController.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/23/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit

class ShoppingCartTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var medicines = [Medicine]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var orderBarButtonItem: UIBarButtonItem!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        orderBarButtonItem.isEnabled = false
        updateTotalLabel()
    }

    func updateTotalLabel() {
        tabBarController?.tabBar.items![2].badgeValue = medicines.isEmpty ? nil : medicines.count.description
        if medicines.isEmpty {
            totalLabel.text = NSLocalizedString("Empty yet", comment: "Total label - empty")
        } else {
            let rowCount = tableView.numberOfRows(inSection: 0)
            var totalPrice: Double = 0
            var hasZeroNumber = false
            for row in 0..<rowCount {
                let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! CartTableViewCell
                totalPrice += Double(cell.number) * medicines[row].price
                if cell.number == 0 {
                    hasZeroNumber = true
                }
            }
            orderBarButtonItem.isEnabled = !hasZeroNumber
            totalLabel.text = NSLocalizedString("Total Price", comment: "Total label - text") + " " + String(totalPrice) + " " + NSLocalizedString("$", comment: "Total label - currency")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)
        if let cartCell = cell as? CartTableViewCell {
            let medicine = medicines[indexPath.row]
            cartCell.nameLabel.text = medicine.name
            cartCell.priceLabel.text = String(medicine.price)
            cartCell.delegate = self
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            medicines.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateTotalLabel()
        }
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

// MARK: - Extensions

extension ShoppingCartTableViewController: CartTableViewCellDelegate {
    
    func stepperValueChanged(_ cell: UITableViewCell, sender: UIStepper) {
        updateTotalLabel()
    }
    
}
