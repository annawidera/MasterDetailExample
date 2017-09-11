//
//  Post.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 05.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import Foundation
import ObjectMapper


struct Post: Mappable {
    
    private static let keys = ["id", "userId", "title", "body"]
    
    var id: Int!
    var userId: Int!
    var title: String!
    var body: String!
    
    // MARK: JSON
    init?(map: Map) {
        guard map.contains(keys: Post.keys) else {
            print("Post")
            dump(map.JSON)
            return nil
        }
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        userId <- map["userId"]
        title <- map["title"]
        body <- map["body"]
    }
    
    init(id: Int, userId: Int, title: String, body: String) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
    }
}
