//
//  ViewController.swift
//  goal-coredata
//
//  Created by Surasak Wattanapradit on 23/1/2562 BE.
//  Copyright © 2562 Surasak Wattanapradit. All rights reserved.
//

import UIKit

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func addGoalPressed(_ sender: Any) {
        print("pressed")
    }
    
}

