//
//  ViewController.swift
//  Damagesingle
//
//  Created by Ryo Hanazaki on 2021/03/12.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var damages: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    private let sections: [String] = ["バトルポケモン","ベンチポケモン"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.isEditing = true
    }
}

extension ViewController: UITableViewDataSource {

    //表示するセルの個数の設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return damages.count - 1
        }
        else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Damagecell") ??
                    UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = String(damages[indexPath.row])
        //cell.countStepper.value = damages[indexPath.row].value
        return cell
    }

    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
            return sections.count
    }

    //セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        damages.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let damage = damages[sourceIndexPath.row]
        damages.remove(at: sourceIndexPath.row)
        damages.insert(damage, at: destinationIndexPath.row)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let damage = damages[indexPath.row]
        let alert = UIAlertController(title: "タイトル", message: String(damage), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}


