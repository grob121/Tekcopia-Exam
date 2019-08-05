//
//  RequestHelper.swift
//  Tekcopia Exam
//
//  Created by Allan Pagdanganan on 31/07/2019.
//  Copyright © 2019 Allan Pagdanganan. All rights reserved.
//

import Foundation

class RequestHelper {
    
    func loginUser(matching query: [String:Any], completion: @escaping (Bool, String?) -> Void) {
        
        let baseURL = URL(string: "http://54.68.88.28/mobile_examination/api/login")!
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.httpBody = getRequestBody(params: query).data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let data = data,
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let dataDict = jsonDict["data"] as? [String: Any], let token = dataDict["token"] as? String {
                    completion(true, token)
                }
                if let data = data,
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let error = jsonDict["error"] as? String {
                        completion(false, error)
                    }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
                completion(false, nil)
            }
        }
        task.resume()
    }
    
    func registerAccount(matching query: [String:Any], completion: @escaping (Bool, String?) -> Void) {
        
        let baseURL = URL(string: "http://54.68.88.28/mobile_examination/api/register")!
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.httpBody = getRequestBody(params: query).data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let data = data,
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let dataDict = jsonDict["data"] as? [String: Any], let token = dataDict["token"] as? String {
                    completion(true, token)
                }
                if let data = data,
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let errorDict = jsonDict["error"] as? [String: Any] {
                        if let nameError = errorDict["name"] as? [String] {
                            completion(false, nameError[0])
                        }
                        if let emailError = errorDict["email"] as? [String] {
                            completion(false, emailError[0])
                        }
                        if let passwordError = errorDict["password"] as? [String] {
                            completion(false, passwordError[0])
                        }
                        if let confirmPasswordError = errorDict["c_password"] as? [String] {
                            completion(false, confirmPasswordError[0])
                        }
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
                completion(false, nil)
            }
        }
        task.resume()
    }
    
    func getOrderItems(matching token: String, completion: @escaping ([Order]?) -> Void) {
        
        let baseURL = URL(string: "http://54.68.88.28/mobile_examination/api/cart")!
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
                let jsonDict = try? jsonDecoder.decode(OrderItems.self, from: data) {
                completion(jsonDict.OrderItems)
            } else {
                completion(nil)
                print("Either no data was returned, or data was not serialized.")
                return
            }
        }
        task.resume()
    }
    
    func addOrder(matching token: String, query: [String:Any], completion: @escaping (Bool, String?) -> Void) {
        
        let baseURL = URL(string: "http://54.68.88.28/mobile_examination/api/cart")!
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = getRequestBody(params: query).data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let data = data,
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let dataDict = jsonDict["OrderItems"] as? [String: Any], let price = dataDict["price"] as? String {
                    completion(true, price)
                }
                if let data = data,
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let errorDict = jsonDict["error"] as? [String: Any] {
                    if let priceError = errorDict["price"] as? [String] {
                        completion(false, priceError[0])
                    }
                    if let categoryIdError = errorDict["category_id"] as? [String] {
                        completion(false, categoryIdError[0])
                    }
                    if let quantityError = errorDict["quantity"] as? [String] {
                        completion(false, quantityError[0])
                    }
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
                completion(false, nil)
            }
        }
        task.resume()
    }
    
    func getRequestBody(params:[String:Any]) -> String {
        
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        
        print(data.map { String($0) }.joined(separator: "&"))
        return data.map { String($0) }.joined(separator: "&")
    }
    
}

