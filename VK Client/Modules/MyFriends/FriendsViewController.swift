//
//  FriendsViewController.swift
//  VK Client
//
//  Created by Сергей Беляков on 06.06.2021.
//

import UIKit
import SDWebImage

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var apiService = API()
    var friends: [User] = []
    private var transitionUser: Any = ""
    
    @IBOutlet var popUpView: UIView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var friendsTableView: UITableView! {
        didSet {
            friendsTableView.delegate = self
            friendsTableView.dataSource = self
            friendsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        group.enter()
        apiService.getFriends { [weak self] users in
            guard let self = self else { return }
            self.friends = users
            group.leave()
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.friendsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        cell.imageView?.sd_setImage(with: URL(string: friend.photo100), placeholderImage: UIImage())
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "fromFriendsToPhotoSegue" else { return }
        guard let destination = segue.destination as? UserPhotosCollectionViewController else { return }
        destination.transitionUser = self.transitionUser
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = friends[indexPath.row]
        transitionUser = user
        addPopUpView(user: user)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    // MARK: -- Добавляем всплывающее меню:
    
    @IBAction func ShowGroupsButton(_ sender: UIButton) {
        removePopUpView()
    }
    
    @IBAction func ShowPhotoButton(_ sender: Any) {
        removePopUpView()
        performSegue(withIdentifier: "fromFriendsToPhotoSegue", sender: transitionUser)
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        removePopUpView()
    }
    
    func addPopUpView (user: User) {
        self.friendsTableView.addSubview(popUpView)
        popUpView.layer.position = CGPoint(x: self.friendsTableView.frame.size.width/2, y: self.friendsTableView.frame.size.height/2.5)
        popUpView.layer.cornerRadius = 10
        popUpView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        popUpView.alpha = 0
        usernameLabel.text = user.firstName + " " + user.lastName
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.popUpView.alpha = 0.8
            self.popUpView.transform = CGAffineTransform.identity
            self.friendsTableView.bringSubviewToFront(self.popUpView)
        }, completion: nil)
    }
    
    func removePopUpView() {
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
                        self.popUpView.alpha = 0
                       }) {(success: Bool) in
            self.popUpView.removeFromSuperview()
        }
        
    }
    
}
