//
//  OrderListViewController.swift
//  Tekcopia Exam
//
//  Created by Allan Pagdanganan on 31/07/2019.
//  Copyright © 2019 Allan Pagdanganan. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func logout(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addOrder(_ sender: Any) {
        performSegue(withIdentifier: "showAddOrderView", sender: nil)
    }
    
}
