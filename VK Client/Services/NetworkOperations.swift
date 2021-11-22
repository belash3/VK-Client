//
//  NetworkOperations.swift
//  VK Client
//
//  Created by Сергей Беляков on 01.08.2021.
//

import UIKit
import Alamofire
import RealmSwift

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

class GetDataOperation: AsyncOperation {
  
  override func cancel() {
    request.cancel()
    super.cancel()
  }
  
  private var request: DataRequest
  private(set) var data: Data?
  
  override func main() {
    request.responseData { [weak self]
      response in
      self?.data = response.data
      self?.state = .finished
    }
  }
  
  init(request: DataRequest) {
    self.request = request
  }
}

final class ParseDataOperation: AsyncOperation {
  
  private(set) var users: [User]?
  
  override func main() {
    
    guard let operation = self.dependencies.first as? GetDataOperation,
          let data = operation.data
    
    else { return }
    
    guard let users = try? JSONDecoder().decode(Friends.self, from: data).response.items else { return }
    self.users = users
    self.state = .finished
  }
}

final class SaveDataOperation: AsyncOperation {
  
  private(set) var friends: Results<User>?
  
  override func main() {
    guard let operation = self.dependencies.first as? ParseDataOperation,
          let users = operation.users
    else { return }
    for item in users {
    databaseService.save(object: item, update: true)
    }
      self.state = .finished
    }
  }


final class ReadDataOperation: AsyncOperation {
  
  private(set) var friends: Results<User>?
  
  override func main() {
    
    guard (self.dependencies.first as? SaveDataOperation) != nil else { return }
    self.friends = databaseService.read(object: User(), tableView: FriendsViewController().friendsTableView, collectionView: nil)
    self.state = .finished
  }
}


