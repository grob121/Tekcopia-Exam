//
//  LoginViewController.swift
//  Tekcopia Exam
//
//  Created by Allan Pagdanganan on 31/07/2019.
//  Copyright © 2019 Allan Pagdanganan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emailField.text = ""
        passwordField.text = ""
        view.endEditing(true)
    }
    
    @IBAction func login(_ sender: Any) {
        [emailField, passwordField].fieldsEmpty ? showAlert(title: "Error", message: "Please complete the form to continue.", actions: ["OK"]) : performSegue(withIdentifier: "showOrderListView", sender: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "showCreateAccountView", sender: nil)
    }
    
}
