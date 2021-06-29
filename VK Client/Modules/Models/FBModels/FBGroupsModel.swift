//
//  FBGroups.swift
//  VK Client
//
//  Created by Сергей Беляков on 29.06.2021.
//

import Foundation
import FirebaseDatabase

class FBGroupModel {
  var groups: String
  var photo: String
  var ref: DatabaseReference?
  
  init(groups: String, photo: String) {
    self.groups = groups
    self.photo = photo
    ref = nil
  }
  
  init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: Any],
      let groups = value["name"] as? String,
      let photo = value["photo"] as? String
    else {
      return nil
    }
    
    self.ref = snapshot.ref
    self.groups = groups
    self.photo = photo
  }
  
  func toAnyObject() -> [AnyHashable: Any] {
    return [ "name": groups, "photo": photo  ] as [AnyHashable: Any]
  }
  
}
