//
//  ViewController.swift
//  collectioncheck
//
//  Created by 花崎諒 on 2021/03/26.
//

import UIKit

// 背景用のView
class CellBgView: UIView {

    init(colorcode: String) {
        super.init(frame: CGRect.zero)
        // 偶数と奇数で色変えてみよう
        backgroundColor = UIColor(hex: colorcode, alpha: 0.5)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ConditionCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var tableView: UITableView!
    var CoinBarButtonItem: UIBarButtonItem!
    
    var battlepokemon: [Pokemon] = []
    var benchpokemons: [Pokemon] = []
    var condition: [Condition] = []
    
    private let sections: [String] = ["バトルポケモン","ベンチポケモン"]
    var conditionsection = ["状態異常"]
    private var coin = "表"
    
    func loadpokemonData() {
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
    
    func loadconditionData() {
        condition.append(Condition(ConditionName: "どく", CellColor: "ba55d3"))
        condition.append(Condition(ConditionName: "やけど", CellColor: "ea5550"))
        condition.append(Condition(ConditionName: "ねむり", CellColor: "a9a9a9"))
        condition.append(Condition(ConditionName: "まひ", CellColor: "fff462"))
        condition.append(Condition(ConditionName: "こんらん", CellColor: "ffffc6"))
        condition.append(Condition(ConditionName: "にげる", CellColor: "adadad"))
        condition.append(Condition(ConditionName: "サポート", CellColor: "ffb266"))
        condition.append(Condition(ConditionName: "GX", CellColor: "0099cc"))
    }
    
    @objc func CoinBarButtonTapped(_sender: UIBarButtonItem) {
        let randomBool = Bool.random()
        if randomBool {
            coin = "表"
        }
        else{
            coin = "裏"
        }
        let alert = UIAlertController(title: "コイントス結果", message: coin, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.isEditing = true
        
        CoinBarButtonItem = UIBarButtonItem(title: "コイントス", style: .done, target: self, action: #selector(self.CoinBarButtonTapped))
        self.navigationItem.rightBarButtonItems = [CoinBarButtonItem]
        
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: ConditionCollectionView.frame.width / 2, height: ConditionCollectionView.frame.height / 3)
        
        loadpokemonData()
        loadconditionData()

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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
            
        // "Cell" はストーリーボードで設定したセルのID
        let conditionCell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell",
                                               for: indexPath)

        let ConditionButton = conditionCell.contentView.viewWithTag(1) as! UIButton
        ConditionButton.setTitle(condition[indexPath.row].ConditionName, for: .normal)
        ConditionButton.setTitleColor(UIColor(hex: "000000"), for: .normal)
        conditionCell.backgroundColor = UIColor(hex: "ffffff")
        conditionCell.selectedBackgroundView = CellBgView(colorcode: condition[indexPath.row].CellColor)
        
        func tapConditon(_ sender: Any) {
            
        }
            
        return conditionCell
    }
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は１つ
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return condition.count;
    }
    
}
