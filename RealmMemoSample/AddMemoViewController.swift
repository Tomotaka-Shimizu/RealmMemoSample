//
//  AddMemoViewController.swift
//  RealmMemoSample
//
//  Created by 清水智貴 on 2020/06/16.
//  Copyright © 2020 tomotaka.com. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class AddMemoViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var createButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        memoTextView.delegate = self
    }
    
    // MARK: - TextView Delegate
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    // メモを作成して保存するコード
    @IBAction func create() {
        // メモの作成
        let memo = Memo.create()
        memo.memo = memoTextView.text
        // メモの保存
        memo.save()
        // メモ一覧に戻る
        self.navigationController?.popViewController(animated: true)
    }

}
