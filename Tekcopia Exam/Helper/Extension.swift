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
        
        if !actions.isEmpty {
            if actions.count > 1  {
                for action in actions {
                    if action == "OK" {
                        alert.addAction(UIAlertAction(title: action, style: .default, handler: {(action: UIAlertAction!) in
                            if alert.title == "Are you sure you want to logout?" {
                                UserDefaults.standard.removeObject(forKey: "token")
                                self.navigationController?.popViewController(animated: true)
                            } else {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }))
                    } else {
                        alert.addAction(UIAlertAction(title: action, style: .default, handler: nil))
                    }
                }
            } else {
                alert.addAction(UIAlertAction(title: actions[0], style: .default, handler: nil))
            }
        } 
        
        present(alert, animated: true)
    }
    
}

extension Array where Element == UITextField {
    
    var fieldsWithContent: Bool {
        return !contains(where: { $0.text!.trimmingCharacters(in: .whitespaces).count > 0 })
    }
    
}

extension URL {
    
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1)}
        return components?.url
    }
    
}



