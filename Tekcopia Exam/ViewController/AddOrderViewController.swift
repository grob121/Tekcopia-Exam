//
//  AddOrderViewController.swift
//  Tekcopia Exam
//
//  Created by Allan Pagdanganan on 31/07/2019.
//  Copyright © 2019 Allan Pagdanganan. All rights reserved.
//

import UIKit

class AddOrderViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var categoryIdField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var updatedAtField: UITextField!
    @IBOutlet weak var createdAtField: UITextField!

    let datePicker = UIDatePicker()
    
    let requestHelper = RequestHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updatedAtField.delegate = self
        createdAtField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
    
    @IBAction func closeView(_ sender: Any) {
        [priceField, categoryIdField, quantityField, updatedAtField, createdAtField].fieldsWithContent ? dismiss(animated: true, completion: nil) : showAlert(title: "Are you sure you want to exit?", message: "This will discard your changes.", actions: ["Cancel","OK"])
    }
    
    @IBAction func add(_ sender: Any) {
        addOrder()
    }
    
    func addOrder() {
        let queries: [String: Any] = [
            "price":"\(priceField.text!)",
            "category_id":"\(categoryIdField.text!)",
            "quantity":"\(quantityField.text!)",
            "updated_at":"\(updatedAtField.text!)",
            "created_at":"\(createdAtField.text!)"
        ]
        
        requestHelper.addOrder(matching: UserDefaults.standard.value(forKey: "token") as! String, query: queries) { (isAddOrder, addOrderStr)   in
            DispatchQueue.main.async {
                if isAddOrder == false {
                    if let addOrderStr = addOrderStr {
                        self.showAlert(title: "Error", message: addOrderStr, actions: ["OK"])
                    } else {
                        self.showAlert(title: "Error", message: "System error occured.", actions: ["OK"])
                    }
                } else {
                    self.priceField.text = ""
                    self.categoryIdField.text = ""
                    self.quantityField.text = ""
                    self.updatedAtField.text = ""
                    self.createdAtField.text = ""
                    self.view.endEditing(true)
                    
                    self.showAlert(title: "", message: "You have successfully added your order.", actions: ["OK"])
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == createdAtField || textField == updatedAtField  {
            showDatePicker(textField)
        }
    }
    
    func showDatePicker(_ textField : UITextField){
        datePicker.datePickerMode = .dateAndTime
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = DatePickerBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker(sender:)));
        doneButton.textFieldParam = textField
        let spaceButton = DatePickerBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = DatePickerBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }
    
    @objc func donedatePicker(sender: DatePickerBarButtonItem){
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:SS"
        sender.textFieldParam!.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        view.endEditing(true)
    }
    
}

class DatePickerBarButtonItem: UIBarButtonItem {
    var textFieldParam: UITextField?
}
