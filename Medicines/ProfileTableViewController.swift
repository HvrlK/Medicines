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
    
    var isChangePassword = false
    var isChangeEmail = false
    var isChangePhoneNumber = false
    
    // MARK: - Outlets
    
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var changeEmailButton: UIButton!
    @IBOutlet weak var changePhoneNumberButton: UIButton!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return isChangePassword ? 3 : 1
        } else if section == 2 {
            return isChangeEmail ? 2 : 1
        } else {
            return isChangePhoneNumber ? 2 : 1
        }
    }

    @IBAction func changePasswordButtonTapped() {
        isChangePassword = !isChangePassword
        changePasswordButton.setTitle(isChangePassword ? NSLocalizedString("Cancel", comment: "Change password button - cancel") : NSLocalizedString("Change Password", comment: "Change password button - change"), for: .normal)
        tableView.reloadData()
    }
    
    @IBAction func changeEmailButtonTapped() {
        isChangeEmail = !isChangeEmail
        changeEmailButton.setTitle(isChangeEmail ? NSLocalizedString("Cancel", comment: "Change email button - cancel") : NSLocalizedString("Change Email", comment: "Change email button - change"), for: .normal)
        tableView.reloadData()
    }
    
    @IBAction func changePhoneNumberButtonTapped() {
        isChangePhoneNumber = !isChangePhoneNumber
        changePhoneNumberButton.setTitle(isChangePhoneNumber ? NSLocalizedString("Cancel", comment: "Change phone button - cancel") : NSLocalizedString("Change Phone Number", comment: "Change phone button - change"), for: .normal)
        tableView.reloadData()
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
