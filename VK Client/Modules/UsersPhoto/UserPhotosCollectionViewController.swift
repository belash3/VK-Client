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
    private let databaseService = DatabaseServiceImpl()
    private var urlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibFile = UINib(nibName: "CustomPhotoCollectionViewCell", bundle: nil)
        self.collectionView.register(nibFile, forCellWithReuseIdentifier: reuseIdentifier)
        guard let user = transitionUser as? User else {return}
        apiService.getPhotosByUser(user: user) { [weak self] photoGallery in
           guard let self = self else { return }
            for item in photoGallery {
                self.databaseService.save(object: item, update: true)
            }
            guard let albumArray = self.databaseService.read(object: Photo()) else {return}
            albumArray.forEach {
                let item = $0.sizeList
                item.forEach {
                    if $0.type == "m"  {
                        self.urlArray.append($0.url)
                    }
                }
            }
            self.collectionView.reloadData()
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
