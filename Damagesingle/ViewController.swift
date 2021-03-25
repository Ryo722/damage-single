//
//  ViewController.swift
//  Damagesingle
//
//  Created by Ryo Hanazaki on 2021/03/12.
//

import UIKit


class ViewController: UIViewController {
    var battlepokemon: [Pokemon] = []
    var benchpokemons: [Pokemon] = []
    var condition: [Condition] = []
    private let sections: [String] = ["バトルポケモン","ベンチポケモン"]
    var conditionsection = ["状態異常"]
    private var coin = "表"
    
    var CoinBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var ConditionCollectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoinBarButtonItem = UIBarButtonItem(title: "コイントス", style: .done, target: self, action: #selector(self.CoinBarButtonTapped))
        self.navigationItem.rightBarButtonItems = [CoinBarButtonItem]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.isEditing = true
        
        ConditionCollectionView.dataSource = self
        ConditionCollectionView.delegate = self
        
        loadData()
        loadData2()
        
    }
    
    func loadData() {
        battlepokemon.append(Pokemon(PokemonNumLabel: 1, PokemonDamageLabel: 0))
        benchpokemons.append(Pokemon(PokemonNumLabel: 2, PokemonDamageLabel: 0))
        benchpokemons.append(Pokemon(PokemonNumLabel: 3, PokemonDamageLabel: 0))
        benchpokemons.append(Pokemon(PokemonNumLabel: 4, PokemonDamageLabel: 0))
        benchpokemons.append(Pokemon(PokemonNumLabel: 5, PokemonDamageLabel: 0))
        benchpokemons.append(Pokemon(PokemonNumLabel: 6, PokemonDamageLabel: 0))
        benchpokemons.append(Pokemon(PokemonNumLabel: 7, PokemonDamageLabel: 0))
        benchpokemons.append(Pokemon(PokemonNumLabel: 8, PokemonDamageLabel: 0))
        benchpokemons.append(Pokemon(PokemonNumLabel: 9, PokemonDamageLabel: 0))
    }
    
    func loadData2() {
        condition.append(Condition(ConditionName: "どく", CellColor: "紫"))
        condition.append(Condition(ConditionName: "やけど", CellColor: "あか"))
        condition.append(Condition(ConditionName: "ねむり", CellColor: "灰色"))
        condition.append(Condition(ConditionName: "まひ", CellColor: "黄色"))
        condition.append(Condition(ConditionName: "こんらん", CellColor: "うす黄色"))
        condition.append(Condition(ConditionName: "サポート", CellColor: "しろ"))
    }


    @objc func CoinBarButtonTapped(_sender: UIBarButtonItem) {
        let randomBool = Bool.random()
        if randomBool {
            coin = "表"
        }
        else{
            coin = "裏"
        }
        //print(coin)
        let alert = UIAlertController(title: "コイントス結果", message: coin, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {

    //表示するセルの個数の設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return benchpokemons.count
        }
        else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as? PokemonTableViewCell else {
                    fatalError("Dequeue failed: PokemonTableCell.")
                }
            cell.PokemonNumLabel.text = String(format: "ポケモン%d : ", battlepokemon[indexPath.row].PokemonNumLabel)
            cell.PokemonDamageLabel.text = String(battlepokemon[indexPath.row].PokemonDamageLabel)
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as? PokemonTableViewCell else {
                    fatalError("Dequeue failed: PokemonTableCell.")
                }
            cell.PokemonNumLabel.text = String(format: "ポケモン%d : ", benchpokemons[indexPath.row].PokemonNumLabel)
            cell.PokemonDamageLabel.text = String(benchpokemons[indexPath.row].PokemonDamageLabel)
            return cell
        }
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
        if indexPath.section == 0 {
            battlepokemon.remove(at: indexPath.row)
        }
        else {
            benchpokemons.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section == 0 && destinationIndexPath.section == 1{
            battlepokemon.remove(at: sourceIndexPath.row)
            benchpokemons.insert(contentsOf: battlepokemon, at: destinationIndexPath.row)
        }
        else if sourceIndexPath.section == 1 && destinationIndexPath.section == 0 {
            benchpokemons.remove(at: sourceIndexPath.row)
            battlepokemon.insert(contentsOf: benchpokemons, at: destinationIndexPath.row)
        }
        else if sourceIndexPath.section == 1 && destinationIndexPath.section == 1 {
            benchpokemons.remove(at: sourceIndexPath.row)
            benchpokemons.insert(contentsOf: benchpokemons, at: destinationIndexPath.row)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let pokemon = battlepokemon[indexPath.row]
            let alert = UIAlertController(title: "タイトル", message: String(pokemon.PokemonDamageLabel), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else {
            let pokemon = benchpokemons[indexPath.row]
            let alert = UIAlertController(title: "タイトル", message: String(pokemon.PokemonDamageLabel), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return condition.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 128, height: 128)
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let conditioncell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConditionCollectionViewCell", for: indexPath) as? ConditionCollectionViewCell else {
                fatalError("Dequeue failed: ConditionViewCell.")
            }
        conditioncell.ConditionButton.titleLabel?.text = String(format: "%@ ", condition[indexPath.row].ConditionName)
        
        //cell.ConditionName = String(format: "%@ ", condition[indexPath.row].ConditionName)
        return conditioncell
    }
}

