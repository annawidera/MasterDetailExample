//
//  PostDetailsViewModel.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 10.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import Foundation


class PostDetailsViewModel {
    
    fileprivate let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var viewTitle: String {
        return post.title
    }
    
    var title: String {
        return post.title
    }
    
    var body: String {
        return post.body
    }
}
