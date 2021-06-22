//
//  DataBaseService.swift
//  VK Client
//
//  Created by Сергей Беляков on 19.06.2021.
//

import Foundation
import RealmSwift

protocol DatabaseService {
    func save<T: Object>(object: T, update: Bool)
    func read<T: Object>(object: T, tableView: UITableView?, collectionView: UICollectionView?) -> Results<T>?
    func delete<T: Object>(object: T)
}

class DatabaseServiceImpl: DatabaseService {
    
    
    let config = Realm.Configuration(schemaVersion: 9, migrationBlock: {
        migration, oldSchemaVersion in
        print("oldSchemaVersion: \(oldSchemaVersion)")
        if oldSchemaVersion < 9 {
            print(" performing migration")
            var nextId = 0
            migration.enumerateObjects(ofType: Photo.className()) {
                oldItem, newItem in
                newItem!["id"] = nextId
                nextId += 1
            }
        }
    })
    
    lazy var mainRealm = try! Realm(configuration: config)
    var token: NotificationToken?
    
    func save<T>(object: T, update: Bool) where T : Object {
        try! mainRealm.write {
            if update {
                mainRealm.add(object, update: .modified)
            } else {
                mainRealm.add(object)
            }
        }
    }
    
    func read<T>(object: T, tableView: UITableView? = nil, collectionView: UICollectionView? = nil) -> Results<T>? where T : Object {
        let model = mainRealm.objects(T.self)
        
        if tableView != nil {
            token = model.observe({ changes in
                guard let tableView = tableView else {return}
                switch changes {
                case .initial:
                    tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    tableView.beginUpdates()
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                    tableView.reloadRows(at: modifications.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                    tableView.endUpdates()
                case .error(let error):
                    print("Error", error.localizedDescription)
                }
                
            })
        }
        if collectionView != nil {
            token = model.observe({ changes in
                guard let collectionView = collectionView else {return}
                switch changes {
                case .initial:
                    collectionView.reloadData()
                case.update(_, let deletions, let insertions, let modifications):
                    collectionView.performBatchUpdates({
                        collectionView.insertItems(at: insertions.map( {IndexPath(row: $0, section: 0)} ))
                        collectionView.deleteItems(at: deletions.map( {IndexPath(row: $0, section: 0)} ))
                        collectionView.reloadItems(at: modifications.map( {IndexPath(row: $0, section: 0)} ))
                    }, completion: nil)
                case .error(let error):
                    print("Error", error.localizedDescription)
                }
            })
        }
        return model
    }
    
    func delete<T>(object: T) where T : Object {
        try! mainRealm.write{
            mainRealm.delete(object)
        }
    }
    
    func deleteAll() {
        try! mainRealm.write{
            mainRealm.deleteAll()
        }
    }
    
}
