//
//  APIServices.swift
//  VK Client
//
//  Created by Сергей Беляков on 06.06.2021.
//

import Foundation
import Alamofire
import RealmSwift
import PromiseKit

class API {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let cliendId = Session.shared.selfUserId
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
    
    func groupsRequest() -> Promise<Data> {
        return Promise<Data> { resolver in
            let method = "/groups.get"
            let parameters: Parameters = [
                "user_id": cliendId,
                "count": 100,
                "extended": 1,
                "access_token": token,
                "v": "5.131"]
            let url = baseUrl + method
            AF.request(url, method: .get, parameters: parameters).responseJSON { response in
                if let error = response.error {
                    resolver.reject(error)
                }
                if let data = response.data {
                    resolver.fulfill(data)
                    }
                }
            }
        }
    
    func getGroupsFromData(from data: Data) -> Promise<Groups> {
        return Promise<Groups> { resolver in
            do {
                let groupsResponse = try JSONDecoder().decode(Groups.self, from: data)
                resolver.fulfill(groupsResponse)
            } catch {
                resolver.reject(error)
            }
        }
    }
    
    func displayGroups(from groupsResponse: Groups) -> Promise<[Group]> {
        return Promise<[Group]> { resolver in
            let groups = groupsResponse.response.items
                resolver.fulfill(groups)
        }
    }
    
    
    //var news: NewsResponse?
    func getNews(completion: @escaping (NewsResponse) -> Void) {
        let parameters: Parameters = [
            "filters": "post",
            "access_token": Session.shared.token,
            "v": "5.131"]
        let method = "/newsfeed.get"
        let url = baseUrl + method
        AF.request(url, method: .get, parameters: parameters).responseData {
            response in
            guard let data = response.data else { return }
            print("NEWS JSON = ", data.prettyJSON as Any)
            do {
                let news = try JSONDecoder().decode(News.self, from: data).response
                DispatchQueue.main.async {
                    completion(news!)
                }
            } catch {
                print (error)
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
}

