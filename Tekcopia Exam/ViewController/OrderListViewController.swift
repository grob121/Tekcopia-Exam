//
//  OrderListViewController.swift
//  Tekcopia Exam
//
//  Created by Allan Pagdanganan on 31/07/2019.
//  Copyright © 2019 Allan Pagdanganan. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var orderTableView: UITableView!
    
    let requestHelper = RequestHelper()
    var OrderItems = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        orderTableView.isHidden = true
        
        requestHelper.getOrderItems(matching: UserDefaults.standard.value(forKey: "token") as! String) { (orders)  in
            DispatchQueue.main.async {
                if let OrderItems = orders {
                    if OrderItems.count > 0 {
                        self.OrderItems = OrderItems
                        self.orderTableView.isHidden = false
                        self.orderTableView.reloadData()
                    }
                } else {
                    self.showAlert(title: "Error", message: "System error occured.", actions: ["OK"])
                }
            }
        }
    }

    @IBAction func logout(_ sender: Any) {
       showAlert(title: "Are you sure you want to logout?", message: "This will end your session.", actions: ["Cancel","OK"])
    }
    
    @IBAction func addOrder(_ sender: Any) {
        performSegue(withIdentifier: "showAddOrderView", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"orderTableViewCell") as! OrderTableViewCell
        
        let orderItems = OrderItems[indexPath.row]
        cell.priceLabel.text = "\(orderItems.price)"
        cell.categoryIdLabel.text = "\(orderItems.categoryId)"
        cell.quantityLabel.text = "\(orderItems.quantity)"
        cell.createdAtLabel.text = orderItems.createdAt
        cell.updatedAtLabel.text = orderItems.updatedAt
        
        return cell
    }
    
}
