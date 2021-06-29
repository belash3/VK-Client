//
//  Session.swift
//  VK Client
//
//  Created by Сергей Беляков on 06.06.2021.
//

import Foundation

final class Session {
    static let shared = Session()
    
    private init() {}
    
    var token = ""
    var selfUserId = "23441019"
}
