//
//  GroupsViewController.swift
//  VK Client
//
//  Created by Сергей Беляков on 08.06.2021.
//

import UIKit
import SDWebImage
import Firebase
import PromiseKit
import Alamofire

class GroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var apiService = API()
    var groups: [Group] = []
    private let databaseService = DatabaseServiceImpl()
    private let ref = Database.database().reference(withPath: "user")
    private var groupsFB = [FBGroupModel]()
    
    @IBOutlet weak var groupsTableView: UITableView! {
        didSet {
            groupsTableView.delegate = self
            groupsTableView.dataSource = self
            groupsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "GroupCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstly {
            apiService.groupsRequest()
        }.then { groupsResponse in
            self.apiService.getGroupsFromData(from: groupsResponse)
        }.then { groups in
            self.apiService.displayGroups(from: groups)
        }.done { parsedGroups in
            self.groups = parsedGroups
            self.groupsTableView.reloadData()
        }.catch { error in
            print(error)
        }
        
//        self.ref.child(Session.shared.selfUserId).child("groups").observe(.value, with: { snapshot in
//                 var newGroupFB: [FBGroupModel] = []
//           for child in snapshot.children {
//             if let snapshot = child as? DataSnapshot,
//                let group = FBGroupModel(snapshot: snapshot) {
//               newGroupFB.append(group)
//                     }
//                 }
//                 self.groupsFB = newGroupFB
//                 self.groupsTableView.reloadData()
//             })
//
//        apiService.getGroups { [weak self] groupsArray in
//            guard let self = self else { return }
//            for item in groupsArray {
//                self.databaseService.save(object: item, update: true)
//            }
//            guard let item = self.databaseService.read(object: Group(), tableView: self.groupsTableView) else {return}
//            self.groups.append(contentsOf: item)
//
//
//            for item in self.groups {
//              let fbGroups = FBGroupModel(groups: item.name, photo: item.photo100).toAnyObject()
//                self.ref.child(Session.shared.selfUserId).child("groups").child(String(item.id)).setValue(fbGroups)
//            }
//            self.groupsTableView.reloadData()
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
        let group = groups[indexPath.row]
        cell.textLabel?.text = "\(group.name)"
        cell.imageView?.sd_setImage(with: URL(string: group.photo100), placeholderImage: UIImage())
        return cell
    }
    
    
}
