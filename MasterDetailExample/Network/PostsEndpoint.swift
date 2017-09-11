//
//  PostsEndpoint.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 05.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import Foundation
import Moya

enum PostsEndpoint: TargetType {
    
    case getPosts
    case addPost(post: Post)
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
        switch self {
        case .getPosts: return "posts"
        case .addPost: return "posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPosts: return .get
        case .addPost: return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getPosts: return nil
        case .addPost(let post): return post.toJSON()
        }
    }
    
    public var parameterEncoding: Moya.ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
//        switch self {
//        case .getPosts:
//            let jsonString = "[[
//            {
//                "userId": 1,
//                "id": 1,
//                "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
//                "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
//            },
//            {
//                "userId": 1,
//                "id": 2,
//                "title": "qui est esse",
//                "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
//            },
//            {
//                "userId": 1,
//                "id": 3,
//                "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
//                "body": "et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut"
//            },
//            {
//                "userId": 1,
//                "id": 4,
//                "title": "eum et est occaecati",
//                "body": "ullam et saepe reiciendis voluptatem adipisci\nsit amet autem assumenda provident rerum culpa\nquis hic commodi nesciunt rem tenetur doloremque ipsam iure\nquis sunt voluptatem rerum illo velit"}]"
//            if let data = jsonString.data(using: .utf8) {
//                return data
//            } else {
//                print("Couldn't serialize example string")
//                return Data()
//            }
//        default: return Data()
//        }
        return Data()
    }
    
    var task: Task {
        return .request
    }
    
}
