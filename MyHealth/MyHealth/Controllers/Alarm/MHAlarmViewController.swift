//
//  MHAlarmViewController.swift
//  MyHealth
//
//  Created by Mai Hoang Anh on 5/4/18.
//  Copyright © 2018 Mai Hoang Anh. All rights reserved.
//

import UIKit

enum MHAlarmSection: Int {
    case exercise = 0
    case meal
    case sleep
    
    case _count
    static func count() -> Int {
        return MHAlarmSection._count.rawValue
    }
}

class MHAlarmViewController: UITableViewController {
    private let sectionTitles: [String] = ["Exercise", "Meal", "Sleep"]
    private var selectedArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Datasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return MHAlarmSection.count()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + (selectedArray.contains(section) ? 2 : 0)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return sectionHeaderCell(tableView: tableView, indexPath: indexPath)
        }
        return contentTableCell(tableView: tableView, indexPath: indexPath)
    }
    
    private func sectionHeaderCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MHAlarmHeaderTableViewCell.cellIdentifier, for: indexPath) as? MHAlarmHeaderTableViewCell {
            cell.updateContentCell(title: sectionTitles[indexPath.section], selected: selectedArray.contains(indexPath.section), indexPath: indexPath)
            cell.onValueChange = { [unowned self] (indexPath, selected) in
                self.switchValueArray(index: indexPath.section)
                self.tableView.reloadData()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    private func contentTableCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MHAlarmContentTableViewCell.cellIdentifier, for: indexPath) as? MHAlarmContentTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    private func switchValueArray(index: Int) {
        if let index = selectedArray.index(of: index) {
            selectedArray.remove(at: index)
        } else {
            selectedArray.append(index)
        }
    }

}
