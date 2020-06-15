//
//  ViewController.swift
//  RealmMemoSample
//
//  Created by 清水智貴 on 2020/06/16.
//  Copyright © 2020 tomotaka.com. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // メモの作成、保存のためにインスタンスを作成
    var memoArray: [Memo] = []
    
    @IBOutlet weak var memoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dataSourceとdelegateメソッドが使えるように。
        memoTableView.delegate = self
        memoTableView.dataSource = self
        //セルの高さを30.0で固定
        memoTableView.rowHeight = 50.0
        //余白を消す
        memoTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // メモを読み込む(Read)
        memoArray = Memo.search()
        // 読み込んだメモをtableViewに反映
        memoTableView.reloadData()
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // メモの数
        return memoArray.count
    }
    
    // tableViewに何を表示するか決める
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell")!
        cell.textLabel?.text = memoArray[indexPath.row].memo
        return cell
    }
    
    // TableViewのcellが押された時に呼ばれる関数
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        // 選択されたcellの選択の解除(メモ一覧に戻った時に選択が解除されている必要があるから)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 画面遷移時の値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailMemoViewController = segue.destination as! DetailMemoViewController
            let selectedIndex = memoTableView.indexPathForSelectedRow!
            detailMemoViewController.selectedMemo = memoArray[selectedIndex.row]
        }
    }

}

