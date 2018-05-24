//
//  ProfileTableViewController.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/23/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var account: Account?
    enum ChangeState {
        case email
        case password
        case phoneNumber
        case none
    }
    var changeState: ChangeState = .none
    
    // MARK: - Outlets
    
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var changeEmailButton: UIButton!
    @IBOutlet weak var changePhoneNumberButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var newEmailTextField: UITextField!
    @IBOutlet weak var newPhoneNumberTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!

    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        newEmailTextField.delegate = self
        newPasswordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        newPhoneNumberTextField.delegate = self
        tableView.tableFooterView = UIView()
        updateLabels()
        updateSaveButton()
    }
    
    func updateLabels() {
        if let account = account {
            nameLabel.text = account.name
            phoneNumberLabel.text = account.phoneNumber
            emailLabel.text = account.email
        }
    }
    
    func updateSaveButton() {
        switch changeState {
        case .email:
            saveBarButtonItem.isEnabled = newEmailTextField.text == "" ? false : true
        case .password:
            saveBarButtonItem.isEnabled = (newPasswordTextField.text == "" || repeatPasswordTextField.text == "") ? false : true
        case .phoneNumber:
            saveBarButtonItem.isEnabled = newPhoneNumberTextField.text == "" ? false : true
        case .none:
            saveBarButtonItem.isEnabled = false
        }
    }
    
    func resetTextFields() {
        let cancelTitle = NSLocalizedString("Cancel", comment: "Change button - cancel")
        changeButtonTitle(cancelTitle: cancelTitle)
        newPhoneNumberTextField.text = nil
        newEmailTextField.text = nil
        newPasswordTextField.text = nil
        repeatPasswordTextField.text = nil
        tableView.reloadData()
    }
    
    func changeButtonTitle(cancelTitle: String? = nil) {
        switch changeState {
        case .email:
            changeEmailButton.setTitle(cancelTitle == nil ? NSLocalizedString("Change Email", comment: "Change email - button title") : cancelTitle, for: .normal)
        case .password:
            changePasswordButton.setTitle(cancelTitle == nil ? NSLocalizedString("Change Password", comment: "Change password - button title") : cancelTitle, for: .normal)
        case .phoneNumber:
            changePhoneNumberButton.setTitle(cancelTitle == nil ? NSLocalizedString("Change Phone Number", comment: "Change phone number - button title") : cancelTitle, for: .normal)
        case .none:
            return
        }
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(
            title: message,
            message: NSLocalizedString("Please, try again.", comment: "Incorrect data - message"),
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: NSLocalizedString("OK", comment: "Incorrect data - OK"),
            style: .default,
            handler: nil
        )
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return changeState == .password ? 3 : 1
        } else if section == 2 {
            return changeState == .email ? 2 : 1
        } else {
            return changeState == .phoneNumber ? 2 : 1
        }
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        for userAccount in fetchRequestFromAccounts(context()) {
            if userAccount == account {
                switch changeState {
                case .email:
                    if let newEmail = newEmailTextField.text, newEmail.contains("@") {
                        userAccount.setValue(newEmail, forKey: "email")
                    } else {
                        showAlert(with: NSLocalizedString("Incorrect email format", comment: "Change email - title"))
                    }
                case .password:
                    if let newPassword = newPasswordTextField.text, newPassword == repeatPasswordTextField.text {
                        userAccount.setValue(newPassword, forKey: "password")
                    } else {
                        showAlert(with: NSLocalizedString("Passwords are not the same", comment: "Change password - title"))
                    }
                case .phoneNumber:
                    if let newPhoneNumber = newPhoneNumberTextField.text {
                        userAccount.setValue(newPhoneNumber, forKey: "phoneNumber")
                    }
                case .none:
                    return
                }
                view.endEditing(false)
                saveContext(context())
                account = userAccount
                changeButtonTitle()
                changeState = .none
                tableView.reloadData()
                updateLabels()
                break
            }
        }
    }
    
    @IBAction func changePasswordButtonTapped(_ sender: UIButton) {
        changeButtonTitle()
        changeState = changeState == .password ? .none : .password
        resetTextFields()
    }
    
    @IBAction func changeEmailButtonTapped(_ sender: UIButton) {
        changeButtonTitle()
        changeState = changeState == .email ? .none : .email
        resetTextFields()
    }
    
    @IBAction func changePhoneNumberButtonTapped(_ sender: UIButton) {
        changeButtonTitle()
        changeState = changeState == .phoneNumber ? .none : .phoneNumber
        resetTextFields()
    }

    @IBAction func exitButtonTapped(_ sender: UIBarButtonItem) {
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "email")
        defaults.set(nil, forKey: "password")
        if let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            appDelegate.window?.rootViewController = loginViewController
        }
    }
    
}

// MARK: - Extension

extension ProfileTableViewController: UINavigationBarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
}

extension ProfileTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateSaveButton()
        return true
    }
    
}
