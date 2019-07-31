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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closeView(_ sender: Any) {
        [nameField, emailField, passwordField, confirmPasswordField].fieldsWithContent ? dismiss(animated: true, completion: nil) : showAlert(title: "Are you sure you want to exit?", message: "This will discard your changes.", actions: ["Cancel","OK"]) 
    }
    
    @IBAction func signUp(_ sender: Any) {
        [nameField, emailField, passwordField, confirmPasswordField].fieldsEmpty ? showAlert(title: "Error", message: "Please complete the form to continue.", actions: ["OK"]) : dismiss(animated: true, completion: nil)
    }
    
}
