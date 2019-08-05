//
//  CreateAccountViewController.swift
//  Tekcopia Exam
//
//  Created by Allan Pagdanganan on 31/07/2019.
//  Copyright © 2019 Allan Pagdanganan. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    let requestHelper = RequestHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }

    @IBAction func closeView(_ sender: Any) {
        [nameField, emailField, passwordField, confirmPasswordField].fieldsWithContent ? dismiss(animated: true, completion: nil) : showAlert(title: "Are you sure you want to exit?", message: "This will discard your changes.", actions: ["Cancel","OK"]) 
    }
    
    @IBAction func signUp(_ sender: Any) {
        registerAccount()
    }
    
    func registerAccount() {
        let queries: [String: Any] = [
            "name":"\(nameField.text!)",
            "email":"\(emailField.text!)",
            "password":"\(passwordField.text!)",
            "c_password":"\(confirmPasswordField.text!)"
        ]
        
        requestHelper.registerAccount(matching: queries) { (isRegister, registerStr)  in
            DispatchQueue.main.async {
                if isRegister == false {
                    if let registerStr = registerStr {
                        self.showAlert(title: "Error", message: registerStr, actions: ["OK"])
                    } else {
                        self.showAlert(title: "Error", message: "System error occured.", actions: ["OK"])
                    }
                } else {
                    self.showAlert(title: "Registration Successful", message: "", actions: [])
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
}
