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
    private let databaseService = DatabaseServiceImpl()
    
    @IBOutlet weak var groupsTableView: UITableView! {
        didSet {
            groupsTableView.delegate = self
            groupsTableView.dataSource = self
            groupsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "GroupCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.getGroups { [weak self] groupsArray in
            guard let self = self else { return }
            for item in groupsArray {
                self.databaseService.save(object: item, update: true)
            }
            guard let item = self.databaseService.read(object: Group()) else {return}
            self.groups.append(contentsOf: item)
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
