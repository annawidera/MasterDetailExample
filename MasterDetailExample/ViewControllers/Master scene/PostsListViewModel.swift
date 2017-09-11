//
//  PostsListViewModel.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 09.07.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper

enum PostsListError {
    case networkError(message: String)
    case mappingArrayError
    case authenticationError
    case clientError(code: Int)
    case serverError(code: Int)
    
    var message: String {
        switch self {
        case let .networkError(message): return message
        case .mappingArrayError: return "Error on parsing data from the API"
        case .authenticationError: return "Authentication error."
        case let .clientError(code): return "Error on communication with a server (client side). Error code: \(code)"
        case let .serverError(code): return "Server error. Error code: \(code)"
        }
    }
}


class PostsListViewModel {
    
    fileprivate let provider: MoyaProvider<PostsEndpoint>
    
    init(provider: MoyaProvider<PostsEndpoint>) {
        self.provider = provider
    }
    
    
    var onError: ((String) -> Void)?
    var onUpdate: ((PostsListViewModel) -> Void)?
    
    var didSelectPost: ((Post) -> Void)?
    var didAddPressed: (() -> Void)?

    let postsViewModelTypes: [CellRepresentable.Type] = [PostCellViewModel.self, NoPostsCellViewModel.self]
    fileprivate(set) var postsViewModels = [CellRepresentable]()
    fileprivate(set) var isUpdating: Bool = false {
        didSet {
            self.onUpdate?(self)
        }
    }
    
    var title: String {
        return "Posts list".localized
    }
    
    
    func reloadData() {
        self.isUpdating = true
        
        provider.request(.getPosts) { result in
            
            switch result {
            case let .success(moyaResponse):
                    let statusCode = moyaResponse.statusCode
                    
                    switch statusCode {
                    case 400...499:
                        self.onError?(PostsListError.clientError(code: statusCode).message)
                        self.postsViewModels = [NoPostsCellViewModel()]
                        self.onUpdate?(self)
                    case 500...599:
                        self.onError?(PostsListError.serverError(code: statusCode).message)
                        self.postsViewModels = [NoPostsCellViewModel()]
                        self.onUpdate?(self)
                    case 200:
                        do {
                            let posts = try moyaResponse.mapArray(Post.self)
                            self.postsViewModels = posts.sorted(by: { $0.0.id < $0.1.id }).map({ self.viewModelFor($0) })
                            if self.postsViewModels.count == 0 {
                                self.postsViewModels = [NoPostsCellViewModel()]
                            }
                        } catch {
                            print("Posts mapping failure")
                            self.onError?(PostsListError.mappingArrayError.message)
                        }
                    default: break
                    }
                
            case let .failure(error):
                print(error.localizedDescription)
                print(error.errorDescription ?? "")
                print(error.failureReason ?? "")
                
                self.onError?(error.localizedDescription)
                self.postsViewModels = [NoPostsCellViewModel()]
                self.onUpdate?(self)
            }
            
            self.isUpdating = false
        }
    }
    
    func addNewCar() {
        self.didAddPressed?()
    }
    
    // MARK: - Helpers
    
    fileprivate func viewModelFor(_ post: Post) -> CellRepresentable {
        
        let viewModel = PostCellViewModel(with: post)
        
        viewModel.didSelect = { [weak self] post in
            self?.didSelectPost?(post)
        }
        return viewModel
    }
    
}
