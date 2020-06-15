//
//  Memo.swift
//  RealmMemoSample
//
//  Created by 清水智貴 on 2020/06/16.
//  Copyright © 2020 tomotaka.com. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class Memo: Object {

    // 初期設定
    static let realm = try! Realm()
    @objc dynamic private var id = 0
    
    // 保存したいデータ(今回の場合はメモ)
    @objc dynamic var memo: String = ""
    
    // 初期設定
    override static func primaryKey() -> String? {
        return "id"
    }
    static func lastId() -> Int {
        if let object = realm.objects(Memo.self).last {
            return object.id + 1
        } else {
            return 1
        }
    }
    
    // 作成(Create)のためのコード
    static func create() -> Memo {
        let memo = Memo()
        memo.id = lastId()
        return memo
    }
    
    // データを保存するためのコード
    func save() {
        try! Memo.realm.write {
            Memo.realm.add(self)
        }
    }
    
    // 保存したものを探す(Read)ためのコード
    static func search() -> [Memo] {

        let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
            }
        })
        Realm.Configuration.defaultConfiguration = config

        if realm.objects(Memo.self).isEmpty == false {
            let objects = realm.objects(Memo.self)
            var memoArray: [Memo] = []
            for object in objects {
                print(object)
                memoArray.append(object)
            }
            return memoArray
        } else {
            return []
        }
    }
    
    // データを更新(Update)するためのコード
    static func update(beforeMemo: String, afterMemo: String) {
        let objects = realm.objects(Memo.self).filter("memo == '\(beforeMemo)'")
        try! realm.write {
            objects.setValue(afterMemo, forKey: "memo")
        }
    }
    
    // データを削除(Delete)するためのコード
    static func delete(wantToDeleteMemo: String) {
        let objects = realm.objects(Memo.self).filter("memo == '\(wantToDeleteMemo)'")
        try! realm.write {
            realm.delete(objects)
        }
    }
    
}
