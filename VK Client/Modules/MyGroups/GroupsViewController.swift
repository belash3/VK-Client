//
//  GroupsViewController.swift
//  VK Client
//
//  Created by Сергей Беляков on 08.06.2021.
//

import UIKit
import SDWebImage

class GroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var apiService = API()
    var groups: [Group] = []
    
    @IBOutlet weak var groupsTableView: UITableView! {
        didSet {
            groupsTableView.delegate = self
            groupsTableView.dataSource = self
            groupsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "GroupCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        group.enter()
        
        apiService.getGroups { [weak self] groups in
            guard let self = self else { return }
            self.groups = groups
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.groupsTableView.reloadData()
        }
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
