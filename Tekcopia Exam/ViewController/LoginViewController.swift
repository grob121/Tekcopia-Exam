//
//  LoginViewController.swift
//  Tekcopia Exam
//
//  Created by Allan Pagdanganan on 31/07/2019.
//  Copyright © 2019 Allan Pagdanganan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func login(_ sender: Any) {
        performSegue(withIdentifier: "showOrderListView", sender: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "showCreateAccountView", sender: nil)
    }
    
}
