//
//  AddOrderViewController.swift
//  Tekcopia Exam
//
//  Created by Allan Pagdanganan on 31/07/2019.
//  Copyright © 2019 Allan Pagdanganan. All rights reserved.
//

import UIKit

class AddOrderViewController: UIViewController {
    
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var categoryIdField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var updatedAtField: UITextField!
    @IBOutlet weak var createdAtField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closeView(_ sender: Any) {
        [priceField, categoryIdField, quantityField, updatedAtField, createdAtField].fieldsWithContent ? dismiss(animated: true, completion: nil) : showAlert(title: "Are you sure you want to exit?", message: "This will discard your changes.", actions: ["Cancel","OK"])
    }
    
    @IBAction func add(_ sender: Any) {
        [priceField, categoryIdField, quantityField, updatedAtField, createdAtField].fieldsEmpty ? showAlert(title: "Error", message: "Please complete the form to continue.", actions: ["OK"]) : showAlert(title: "", message: "You have successfully added your order.", actions: ["OK"])
    }
    
}
