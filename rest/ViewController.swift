//
//  ViewController.swift
//  rest
//
//  Created by Chris Chadillon on 2017-03-15.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import UIKit

func tes(a:[String]) {
    
    print("a")
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doGetJson(_ sender: UIButton) {
        self.makeGetAllCall(comp: tes)
    }

    private func makeGetAllCall(comp: @escaping ([String])->()) {
        // Set up the URL request
        
        let todoEndpoint: String = "http://localhost:8080/json/all_data/"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String: AnyObject]] else {
                    print("error trying to convert data to JSON")
                    return
                }
                //print("The todo is: " + todo.description)
                for person in todo {
                    print(person["password"]!)
                }
                comp(["AAA"])
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }

}

