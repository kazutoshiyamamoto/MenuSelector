//
//  ViewController.swift
//  MenuSelector
//
//  Created by home on 2019/12/28.
//  Copyright © 2019 Swift-beginners. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
}

