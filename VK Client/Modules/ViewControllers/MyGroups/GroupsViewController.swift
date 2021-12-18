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
    var cellsArray: [UITableViewCell] = []
    
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
        }.then { parsedGroups in
            self.makeCell(groups: parsedGroups)
        }.done { cells in
            self.cellsArray = cells
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
        return cellsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellsArray[indexPath.row]
    }
}

extension GroupsViewController {
    func makeCell(groups: [Group] ) -> Promise<[UITableViewCell]> {
        return Promise<[UITableViewCell]> { resolver in
        var cells: [UITableViewCell] = []
            groups.forEach {
                if let cell = self.groupsTableView.dequeueReusableCell(withIdentifier: "GroupCell"){
                    cell.textLabel?.text = "\($0.name)"
                    cell.imageView?.sd_setImage(with: URL(string: $0.photo100), placeholderImage: UIImage())
                    cells.append(cell)
                }
                }
            resolver.fulfill(cells)
        }
    }
}
