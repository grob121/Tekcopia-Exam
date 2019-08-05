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
    
    let requestHelper = RequestHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emailField.text = ""
        passwordField.text = ""
        view.endEditing(true)
    }
    
    @IBAction func login(_ sender: Any) {
        loginUser()
    }
    
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "showCreateAccountView", sender: nil)
    }
    
    func loginUser() {
        let queries: [String: Any] = [
            "email":"\(emailField.text!)",
            "password":"\(passwordField.text!)"
        ]
        
        requestHelper.loginUser(matching: queries) { (isLogin, loginStr)  in
            DispatchQueue.main.async {
                if isLogin == false {
                    if let loginStr = loginStr {
                        self.showAlert(title: "Error", message: loginStr, actions: ["OK"])
                    } else {
                        self.showAlert(title: "Error", message: "System error occured.", actions: ["OK"])
                    }
                } else {
                    UserDefaults.standard.set(loginStr, forKey: "token")
                    self.performSegue(withIdentifier: "showOrderListView", sender: nil)
                }
            }
        }
    }
    
}
