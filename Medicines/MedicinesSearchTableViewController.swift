//
//  MedicinesSearchTableViewController.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/23/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit

class MedicinesSearchTableViewController: UITableViewController {
    
    var medicines: [Medicine] {
        return fetchRequestFromMedicines(context())
    }
    var currentMedicines = [Medicine]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        currentMedicines = medicines
//        addMedicines()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMedicines.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicinesCell", for: indexPath)
        cell.textLabel?.text = currentMedicines[indexPath.row].name
        cell.detailTextLabel?.text = String(currentMedicines[indexPath.row].price)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(
            title: currentMedicines[indexPath.row].name,
            message: NSLocalizedString("Do you want add this medicine to your shopping cart?", comment: "Add medicine alert - title"),
            preferredStyle: .alert
        )
        let OKaction = UIAlertAction(
            title: NSLocalizedString("Yes", comment: "Add medicine alert - yes action"),
            style: .default,
            handler: { _ in
                //TODO: add to cart
        })
        let cancelAction = UIAlertAction(
        title: NSLocalizedString("Cancel", comment: "Add medicine alert - cancel action"),
        style: .cancel,
        handler: nil
        )
        alert.addAction(OKaction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

}

extension MedicinesSearchTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            currentMedicines = medicines.filter { medicine -> Bool in
                medicine.name.lowercased().contains(searchText.lowercased()) || medicine.category.lowercased().contains(searchText.lowercased())
            }
        } else {
            currentMedicines = medicines
        }
        tableView.reloadData()
    }

}

extension MedicinesSearchTableViewController: UISearchControllerDelegate {
    
    func willDismissSearchController(_ searchController: UISearchController) {
        currentMedicines = medicines
        tableView.reloadData()
    }
    
}

extension MedicinesSearchTableViewController {
    
    func addMedicines() {
        let medicine1 = Medicine(context: context())
        medicine1.name = "Амоксил"
        medicine1.category = "Антибактеріальні"
        medicine1.descriptionOfMedicine = "1 таблетка містить амоксициліну тригідрату, у перерахуванні на амоксицилін"
        medicine1.producer = "ПАТ «Київмедпрепарат»"
        medicine1.price = 41.0
        
        let medicine2 = Medicine(context: context())
        medicine2.name = "Септил"
        medicine2.category = "Антисептики"
        medicine2.descriptionOfMedicine = "діюча речовина: 100 мл розчину містять не менше 69,3 % об/об і не більше 70,7 % об/об етанолу (С2Н6О)"
        medicine2.producer = "ТОВ «ДКП «Фармацевтична фабрика»"
        medicine2.price = 26.85
        
        let medicine3 = Medicine(context: context())
        medicine3.name = "Темпалгін"
        medicine3.category = "Болезаспокійливі"
        medicine3.descriptionOfMedicine = "1 таблетка, вкрита оболонкою, містить метамізолу натрію моногідрату 500 мг, темпідону (триацетонамін-4-толуенсульфонату) 20 мг"
        medicine3.producer = "АТ «Софарма»"
        medicine3.price = 31.50
        
        let medicine4 = Medicine(context: context())
        medicine4.name = "Аскорбінова Кислота"
        medicine4.category = "Вітаміни"
        medicine4.descriptionOfMedicine = "діюча речовина: 1 драже містить кислоти аскорбінової (вітаміну С) 50 мг"
        medicine4.producer = "ПАО «Киевский витаминный завод»"
        medicine4.price = 17.07
        
        let medicine5 = Medicine(context: context())
        medicine5.name = "Неовітам"
        medicine5.category = "Вітаміни"
        medicine5.descriptionOfMedicine = "1 таблетка містить: вітаміну В1 (тіаміну гідрохлориду) 100 мг; вітаміну В6 (піридоксину гідрохлориду) 200 мг; вітаміну В12 (ціанокобаламіну) 0,2 мг"
        medicine5.producer = "Київський вітамінний завод"
        medicine5.price = 75.0
        
        saveContext(context())
    }
    
}
