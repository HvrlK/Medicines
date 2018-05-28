//
//  MedicinesSearchTableViewController.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/23/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit

class MedicinesSearchTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var medicines: [Medicine] {
        return fetchRequestFromMedicines(context())
    }
    var currentMedicines = [Medicine]()
    var selectedMedicine: Medicine?

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        if medicines.isEmpty {
            addMedicines()
        }
        currentMedicines = medicines
    }

    func passMedicine() {
        if let tabBarControllers = tabBarController?.viewControllers, let navigationController = tabBarControllers[2] as? UINavigationController, let shoppingCart = navigationController.topViewController as? ShoppingCartTableViewController, let medicine = selectedMedicine {
            shoppingCart.medicines.append(medicine)
            shoppingCart.tableView.reloadData()
            shoppingCart.updateTotalLabel()
        }
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
        cell.detailTextLabel?.text = currentMedicines[indexPath.row].price.description + " " + NSLocalizedString("$", comment: "Total label - currency")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let detailViewController = segue.destination as? DetailViewController, let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                detailViewController.modalPresentationStyle = .overFullScreen
                detailViewController.medicine = medicines[indexPath.row]
            }
        }
    }
    
    @IBAction func unwindSegueFromDetail(_ unwindSeque: UIStoryboardSegue) {
        if unwindSeque.identifier == "AddToCart" {
            if let detailViewController = unwindSeque.source as? DetailViewController {
                selectedMedicine = detailViewController.medicine
                passMedicine()
            }
        }
    }

}

// MARK: - Extensions

extension MedicinesSearchTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            currentMedicines = medicines.filter { medicine -> Bool in
                medicine.name.lowercased().hasPrefix(searchText.lowercased())
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
        
        let medicine6 = Medicine(context: context())
        medicine6.name = "Евказолін Аква"
        medicine6.category = "Краплі назальні"
        medicine6.descriptionOfMedicine = "Прозора злегка жовтувата рідина із специфічним запахом.Засоби, що застосовуються при захворюваннях порожнини носа."
        medicine6.producer = "ПАТ «Фармак»"
        medicine6.price = 51.20
        
        let medicine7 = Medicine(context: context())
        medicine7.name = "Ново-Пасит"
        medicine7.category = "Розчин оральний"
        medicine7.descriptionOfMedicine = "Снодійні та седативні засоби. 100 мл у флаконі; по 1 флакону разом з мірним ковпачком в коробці."
        medicine7.producer = "Тева Чех Індастріз с.р.о"
        medicine7.price = 76.50
        
        let medicine8 = Medicine(context: context())
        medicine8.name = "Аспірин"
        medicine8.category = "Таблетки, 500 мг"
        medicine8.descriptionOfMedicine = "Круглі, плоскоциліндричні таблетки білого кольору, зі скошеними краями; на одному боці - вигравіруваний “байєровський хрест”, на іншому боці – напис “ASPIRIN 0,5” (для таблеток з вмістом ацетилсаліцилової кислоти 500 мг);"
        medicine8.producer = "Байєр АГ/Bayer AG"
        medicine8.price = 38.40
        
        let medicine9 = Medicine(context: context())
        medicine9.name = "Тамипул"
        medicine9.category = "Капсули"
        medicine9.descriptionOfMedicine = "Комбінований лікарський засіб, дія якого зумовлена компонентами, що входять до його складу. Препарат чинить аналгезуючу (знеболювальну), протизапальну, жарознижувальну дії"
        medicine9.producer = "АТ «Гріндекс»"
        medicine9.price = 121.20
        
        let medicine10 = Medicine(context: context())
        medicine10.name = "Пантенол Аерозоль"
        medicine10.category = "Піна нашкірна"
        medicine10.descriptionOfMedicine = "Мазь д-Пантенолзастосовують місцево при порушеннях цілісності шкірних покривів, спричинених механічними ушкодженнями або хірургічними втручаннями, при опіках різного походження, при запальних процесах шкіри, а також для обробки сухої шкіри"
        medicine10.producer = "ТОВ «Мікрофарм»"
        medicine10.price = 48.90
        
        let medicine11 = Medicine(context: context())
        medicine11.name = "Марвелон"
        medicine11.category = "Таблетки"
        medicine11.descriptionOfMedicine = "Гормональні контрацептиви для системного застосування. Естрогени і гестагени у фіксованих комбінаціях"
        medicine11.producer = "Н.В.Органон."
        medicine11.price = 839.15
        
        saveContext(context())
    }
    
}
