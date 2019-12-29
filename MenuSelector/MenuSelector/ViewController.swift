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
    @IBOutlet weak var button: UIBarButtonItem!
    
    @IBOutlet weak var activeTableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var deactiveTableViewTopConstraint: NSLayoutConstraint!
    
    private let tableViewCellTitles = ["新着順", "価格の高い順", "価格の低い順"]
    private var checked: [Bool] = [true, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        self.tableView.layer.cornerRadius = 2.0
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        self.changeTableViewTopConstraint()
    }
    
    private func changeTableViewTopConstraint() {
        if self.activeTableViewTopConstraint.isActive == true {
            NSLayoutConstraint.deactivate([self.activeTableViewTopConstraint])
            NSLayoutConstraint.activate([self.deactiveTableViewTopConstraint])
        } else {
            NSLayoutConstraint.deactivate([self.deactiveTableViewTopConstraint])
            NSLayoutConstraint.activate([self.activeTableViewTopConstraint])
        }
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewCellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.label.text = self.tableViewCellTitles[indexPath.row]
        
        if self.checked[indexPath.row] == false {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                self.checked = (0 ..< 3).map { _ in false }
                
                self.checked[indexPath.row] = true
                print("\(indexPath.row)番目の選択肢が押された")
            }
            self.button.title = self.tableViewCellTitles[indexPath.row]
            self.tableView.reloadData()
            self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
        
        self.changeTableViewTopConstraint()
    }
}

