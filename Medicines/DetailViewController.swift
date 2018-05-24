//
//  DetailViewController.swift
//  Medicines
//
//  Created by Vitalii Havryliuk on 5/24/18.
//  Copyright © 2018 Vitalii Havryliuk. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var medicine: Medicine?
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToShoppingCart: UIButton!
    @IBOutlet weak var popupView: UIView!
    
    // MARK: - Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        view.addGestureRecognizer(tap)
        if let medicine = medicine {
            nameLabel.text = medicine.name
            categoryLabel.text = medicine.category
            producerLabel.text = medicine.producer
            descriptionLabel.text = medicine.descriptionOfMedicine
            priceLabel.text = medicine.price.description + " " + NSLocalizedString("$", comment: "Total label - currency")
        }
        popupView.layer.cornerRadius = 8.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        }
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }

}

// MARK: - Extensions

extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OutAnimationController()
    }
    
}


