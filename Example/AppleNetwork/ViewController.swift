//
//  ViewController.swift
//  AppleNetwork
//
//  Created by sarathraveendran-litmus7 on 09/15/2019.
//  Copyright (c) 2019 sarathraveendran-litmus7. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        HomeDataManager.shared.fetchEmployeesList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

