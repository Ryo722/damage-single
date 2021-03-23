//
//  ModalViewController.swift
//  Damagesingle
//
//  Created by 花崎諒 on 2021/03/23.
//

import UIKit

class ModalViewController: UIViewController {

    @IBOutlet weak var ConditionTableView: UITableView!
    
    var condition: [Condition] = []
    var conditionsection = ["状態異常"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConditionTableView.dataSource = self
        ConditionTableView.delegate = self
        ConditionTableView.tableFooterView = UIView()
        loadData()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        
    }
    
    func loadData() {
        condition.append(Condition(ConditionLabel: "どく"))
        condition.append(Condition(ConditionLabel: "やけど"))
        condition.append(Condition(ConditionLabel: "ねむり"))
        condition.append(Condition(ConditionLabel: "まひ"))
        condition.append(Condition(ConditionLabel: "こんらん"))
    }

}

extension ModalViewController: UITableViewDataSource {
    
    //表示するセルの個数の設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(condition.count)
        return condition.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConditionTableViewCell", for: indexPath) as? ConditionTableViewCell else {
                fatalError("Dequeue failed: ConditionnTableCell.")
            }
        cell.ConditionLabel.text = String(format: "%@ ", condition[indexPath.row].ConditionLabel)
        return cell
    }
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
            return conditionsection.count
    }

    //セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return conditionsection[section]
    }
}


extension ModalViewController: UITableViewDelegate {
    
}
