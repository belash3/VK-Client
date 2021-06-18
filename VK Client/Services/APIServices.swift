//
//  APIServices.swift
//  VK Client
//
//  Created by Сергей Беляков on 06.06.2021.
//

import Foundation
import Alamofire
import RealmSwift

class API {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let cliendId = Session.shared.userId
    let version = "5.131"
    
    func getGroups(completion: @escaping([Group])->()) {
        let method = "/groups.get"
        let parameters: Parameters = [
            "user_id": cliendId,
            "count": 100,
            "extended": 1,
            "access_token": token,
            "v": "5.131"]
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.data else {return}
            guard let groupsResponse = try? JSONDecoder().decode(Groups.self, from: data) else { return }
            let groups = groupsResponse.response.items
            DispatchQueue.main.async {
                completion(groups)
            }
        }
    }
    
    func getPhotosByUser(user: User, completion: @escaping([Photo])->() ) {
        let method = "/photos.getAll"
        let parameters: Parameters = [
            "id": cliendId,
            "owner_id": String(user.id),
            "count": 100,
            "no_service_albums": 1,
            "photo_sizes": 0,
            "access_token": Session.shared.token,
            "v": "5.131"]
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.data else { return }
            //print("PHOTO PRETTY JSON = ", data.prettyJSON as Any)
            guard let userPhotosResponse = try? JSONDecoder().decode(UserPhotos.self, from: data) else { return }
            let photoGallery = userPhotosResponse.response.items
            DispatchQueue.main.async {
                completion(photoGallery)
            }
        }
    }
    
    func getFriends(completion: @escaping([User])->()) {
        
        let method = "/friends.get"
        let parameters: Parameters = [
            "user_id": cliendId,
            "order": "name",
            "count": 100,
            "fields": "photo_100",
            "access_token": Session.shared.token,
            "v": version]
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard let data = response.data else { return }
            guard let friendsResponse = try? JSONDecoder().decode(Friends.self, from: data) else { return }
            let friends = friendsResponse.response.items
            DispatchQueue.main.async {
                completion(friends)
            }
        }
    }
}

extension API {
    
    func saveUserData(by user: [User]) {
        let realm = try! Realm()
        do {
            realm.beginWrite()
            realm.add(user)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func saveGroupData(by group: [Group]) {
        let realm = try! Realm()
        do {
            realm.beginWrite()
            realm.add(group)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func savePhotosData(by photo: [Photo]) {
        let realm = try! Realm()
        do {
            realm.beginWrite()
            realm.add(photo)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
