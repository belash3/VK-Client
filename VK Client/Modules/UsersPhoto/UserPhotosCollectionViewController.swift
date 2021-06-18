//
//  UserPhotosCollectionViewController.swift
//  VK Client
//
//  Created by Сергей Беляков on 09.06.2021.
//

import UIKit
import SDWebImage
import Alamofire

class UserPhotosCollectionViewController: UICollectionViewController {
    
    let reuseIdentifier = "PhotoCell"
    var apiService = API()
    var photoGallery: [Photo] = []
    var transitionUser: Any = ""
    private var urlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibFile = UINib(nibName: "CustomPhotoCollectionViewCell", bundle: nil)
        self.collectionView.register(nibFile, forCellWithReuseIdentifier: reuseIdentifier)
        guard let user = transitionUser as? User else {return}
        let group = DispatchGroup()
        group.enter()
        apiService.getPhotosByUser(user: user) { [weak self] photoGallery in
            guard let self = self else { return }
            self.photoGallery = photoGallery
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        
        apiService.getPhotosByUser(user: user) {  [weak self] photoGallery in
            guard let self = self else { return }
            let albumArray = photoGallery
            albumArray.forEach {
                $0.sizeList.forEach {
                    if $0.type == "m"  {
                        self.urlArray.append($0.url)
                    }
                }
            }
        }
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urlArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CustomPhotoCollectionViewCell else { return UICollectionViewCell() }
        
        let string = urlArray[indexPath.row]
        cell.photoImageView.sd_setImage(with: URL(string: string))
        return cell
        
    }
    
}
