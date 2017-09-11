//
//  Application.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 09.07.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit
import Moya

class Application {
    
    fileprivate let window: UIWindow
    
    lazy var navigation: Navigation = Navigation(
        window: self.window,
        navigationController: NavigationController(),
        application: self)
    
    lazy var postsProvider: MoyaProvider<PostsEndpoint> = MoyaProvider<PostsEndpoint>()
//        {
//
//        let endpointClosure = { (target: CarsEndpoint) -> Endpoint<CarsEndpoint> in
//            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
//            return defaultEndpoint.adding(newHTTPHeaderFields: ["x-apikey": Config.apiKey])
//        }
//        return MoyaProvider<CarsEndpoint>(endpointClosure: endpointClosure)
//    }()
    
    var postFieldsValidator = PostValidator()
    
    init(window: UIWindow) {
        self.window = window
    }
}
