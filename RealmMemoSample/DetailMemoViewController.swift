//
//  DetailMemoViewController.swift
//  RealmMemoSample
//
//  Created by 清水智貴 on 2020/06/16.
//  Copyright © 2020 tomotaka.com. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class DetailMemoViewController: UIViewController {
    
    // 選択されたメモの値を引き継ぐために定義
    var selectedMemo = Memo()
    
    @IBOutlet weak var detailTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 選択されたメモの値を表示
        detailTextView.text = selectedMemo.memo
    }
    
    // メモの更新(Update)
    @IBAction func updateMemo() {
        // beforeMemoは以前保存したメモ、afterMemoは変更したいメモ
        Memo.update(beforeMemo: selectedMemo.memo, afterMemo: detailTextView.text)
        self.navigationController?.popViewController(animated: true)
    }
    
    // メモの削除(Delete)
    @IBAction func deleteMemo() {
        // wantToDeleteMemoは削除したいメモ
        Memo.delete(wantToDeleteMemo: selectedMemo.memo)
        self.navigationController?.popViewController(animated: true)
    }

}
