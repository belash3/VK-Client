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
    func read<T: Object>(object: T) -> Results<T>?
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
    
    func save<T>(object: T, update: Bool) where T : Object {
        try! mainRealm.write {
            if update {
                mainRealm.add(object, update: .modified)
            } else {
                mainRealm.add(object)
            }
        }
    }
    
    func read<T>(object: T) -> Results<T>? where T : Object {
        return mainRealm.objects(T.self)
    }
    
    func delete<T>(object: T) where T : Object {
        try! mainRealm.write{
            mainRealm.delete(object)
        }
    }
    
    
}
