//
//  Extension.swift
//  Tekcopia Exam
//
//  Created by Allan Pagdanganan on 31/07/2019.
//  Copyright © 2019 Allan Pagdanganan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, actions: [String]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if(actions.count > 1) {
            for action in actions {
                if(action == "OK") {
                    alert.addAction(UIAlertAction(title: action, style: .default, handler: dismissHandler(alert:)))
                } else {
                    alert.addAction(UIAlertAction(title: action, style: .default, handler: nil))
                }
            }
        } else {
            alert.addAction(UIAlertAction(title: actions[0], style: .default, handler: nil))
        }
        
        present(alert, animated: true)
    }
    
    func dismissHandler(alert: UIAlertAction!) {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }

}

extension Array where Element == UITextField {
    
    var fieldsEmpty: Bool {
        return contains(where: { $0.text!.trimmingCharacters(in: .whitespaces).isEmpty })
    }
    
    var fieldsWithContent: Bool {
        return !contains(where: { $0.text!.trimmingCharacters(in: .whitespaces).count > 0 })
    }
    
}



