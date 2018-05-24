//
//  ToOrderTableViewController.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/24/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit

class ToOrderTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var houseTextField: UITextField!
    @IBOutlet weak var moneySwitch: UISwitch!
    @IBOutlet weak var commentTextField: UITextField!

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("To Order", comment: "To order - title")
        let barItem = UIBarButtonItem(
            title: NSLocalizedString("Done", comment: "To order - done"),
            style: .done,
            target: self,
            action: #selector(doneButtonTapped(_:)))
        navigationItem.rightBarButtonItem = barItem
        updateDoneButton()
        streetTextField.delegate = self
        houseTextField.delegate = self
        commentTextField.delegate = self
    }
    
    func updateDoneButton() {
        if streetTextField.text == "" || houseTextField.text == ""  {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @objc func doneButtonTapped(_  sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: NSLocalizedString("Your order is successfully complete.", comment: "Order done button - title"),
            message: NSLocalizedString("Wait for the call.", comment: "Order done button - message"),
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: NSLocalizedString("OK", comment: "Order done button - OK"),
            style: .default,
            handler: nil
        )
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - Extensions

extension ToOrderTableViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateDoneButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
