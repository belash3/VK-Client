//
//  FBUsermodel.swift
//  VK Client
//
//  Created by Сергей Беляков on 29.06.2021.
//

import Foundation
import FirebaseDatabase

class FBUserModel {
 
  var lastName: String
  var photo100: String
  var firstName: String
  var ref: DatabaseReference?
  
  internal init(lastName: String, photo100: String, firstName: String, ref: DatabaseReference? = nil) {
    self.lastName = lastName
    self.photo100 = photo100
    self.firstName = firstName
    self.ref = nil
    
  }
  
  init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: Any],
      let lastName  = value["lastName"] as? String,
      let firstName = value["firstName"] as? String,
      let photo100 = value["photo100"] as? String
    else {
      return nil
    }
    self.lastName = lastName
    self.photo100 = photo100
    self.firstName = firstName
  }
  
  func toAnyObject() -> [AnyHashable: Any] {
    return [ "firstName": firstName, "lastName": lastName, "photo100": photo100] as [AnyHashable: Any]
  }
  
}
