//
//  FriendsOperations.swift
//  VK Client
//
//  Created by Сергей Беляков on 01.12.2021.
//

import Foundation
import UIKit
import Alamofire
import RealmSwift


class GetDataOperation: AsyncOperation {
  
  override func cancel() {
    request.cancel()
    super.cancel()
  }
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let cliendId = Session.shared.selfUserId
    let version = "5.131"
    
        var request: DataRequest {
        let method = "/friends.get"
        let parameters: Parameters = [
            "user_id": cliendId,
            "order": "name",
            "count": 100,
            "fields": "photo_100",
            "access_token": Session.shared.token,
            "v": version]
        let url = baseUrl + method
        return AF.request(url, method: .get, parameters: parameters)
    }
    
  private(set) var data: Data?
  
  override func main() {
    request.responseData { [weak self]
      response in
      self?.data = response.data
      self?.state = .finished
    }
  }
}

final class ParseDataOperation: AsyncOperation {
  
  private(set) var friends: [User]?
    
  override func main() {
    guard let operation = self.dependencies.first as? GetDataOperation,
          let data = operation.data,
          let users = try? JSONDecoder().decode(Friends.self, from: data).response.items else { return }
    self.friends = users
      self.state = .finished
  }
}



final class DisplayDataOpreation: AsyncOperation {
    
    var friendsViewController: FriendsViewController
    
    override func main() {
        guard let parsedFriendsList = dependencies.first as? ParseDataOperation,
              let friends = parsedFriendsList.friends else { return }
        self.friendsViewController.friends = friends
        friendsViewController.friendsTableView.reloadData()
        self.state = .finished
    }
    init(controller: FriendsViewController) {
        self.friendsViewController = controller
    }
}


class AsyncOperation: Operation {
  
  enum State: String {
    case ready, executing, finished
    
    fileprivate var keyPath: String {
      return "is" + self.rawValue.capitalized
    }
  }
  
  var state: State = State.ready {
    willSet {
      self.willChangeValue(forKey: self.state.keyPath)
      self.willChangeValue(forKey: newValue.keyPath)
    }
    
    didSet {
      self.didChangeValue(forKey: self.state.keyPath)
      self.didChangeValue(forKey: oldValue.keyPath)
    }
  }
  
  let databaseService = DatabaseServiceImpl()
  
  override var isAsynchronous: Bool {
    return true
  }
  
  override var isReady: Bool {
    return super.isReady && self.state == .ready
  }
  
  override var isExecuting: Bool {
    return self.state == .executing
  }
  
  override var isFinished: Bool {
    return self.state == .finished
  }
  
  override func start() {
    if self.isCancelled {
      self.state = .finished
    } else {
      self.main()
      self.state = .executing
    }
  }
  
  override func cancel() {
    super.cancel()
    self.state = .finished
  }
  
  func finished() {
    self.state = .finished
  }
}
