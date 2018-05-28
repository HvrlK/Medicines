//
//  IlnessesTableViewController.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/24/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit

class IllnessesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    struct Illness {
        var name: String
        var warning: String
    }
    
    let illnesses: [Illness] = [Illness(name: "Авітаміноз", warning: "Повноцінне харчування, вживання додаткових вітамінів A, E, D."), Illness(name: "Алергічна реакція", warning: "Прийому антигістамінних препаратів. Уникати контактів з  алергенами, або принаймні звести такі контакти до мінімуму."), Illness(name: "Грип штамм А", warning: "Вакцинація проти грипу, вживання противірусних препаратів. Дотримання правил гігієни та вживання вітамінів для підвищення імунітету."), Illness(name: "Вірус герпесу", warning: "Правильне харчування, споживати більше вітамінів. Обмежити себе у споживанні солодкого і алкоголю"), Illness(name: "Гайморит", warning: "Уникати переохолодження, використовуватися протизапальні та судинозвужувальні засоби, зміцнювати імунітет")]
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IllnessCell", for: indexPath)
        cell.textLabel?.text = (indexPath.row + 1).description + ". " + illnesses[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(
            title: illnesses[indexPath.row].name,
            message: illnesses[indexPath.row].warning,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: NSLocalizedString("OK", comment: "Illnesses - OK"),
            style: .default,
            handler: nil
        )
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
