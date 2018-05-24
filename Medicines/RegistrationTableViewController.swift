//
//  RegistrationTableViewController.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/15/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordField.delegate = self
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repeatPasswordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        updateCreateButton()
    }
    
    func updateCreateButton() {
        if nameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" || repeatPasswordField.text == "" {
            createButton.isEnabled = false
        } else {
            createButton.isEnabled = true
        }
    }
    
    func showAlertWith(title: String, isSuccess: Bool = false) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        let closeAction = UIAlertAction(
            title: "OK",
            style: .cancel,
            handler: { _ in
                if isSuccess {
                    self.dismiss(animated: true, completion: nil)
                }
        })
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateCreateButton()
    }

    // MARK: - Actions
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        if passwordTextField.text == repeatPasswordField.text {
            if let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text, let phoneNumber = phoneNumberTextField.text {
                let accounts = fetchRequestFromAccounts(context())
                let emails = accounts.map { $0.email.lowercased() }
                if !emails.contains(email.lowercased()) {
                    let newUser = Account(context: context())
                    newUser.name = name
                    newUser.email = email
                    newUser.phoneNumber = phoneNumber
                    newUser.password = password
                    saveContext(context())
                    showAlertWith(title: NSLocalizedString("Your account has been successfully created", comment: "Registration - success"), isSuccess: true)
                } else {
                    showAlertWith(title: NSLocalizedString("This email is already in use", comment: "Registration error - email"))
                }
            }
        } else {
            showAlertWith(title: NSLocalizedString("Passwords are not the same", comment: "Registration error - passwords"))
        }
    }

}

extension RegistrationTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        }
        if let nextField = tableView.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            if createButton.isEnabled {
                createButtonTapped(createButton)
            }
        }
        return true
    }
    
}
