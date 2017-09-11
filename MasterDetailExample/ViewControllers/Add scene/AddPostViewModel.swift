//
//  AddPostViewModel.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 10.07.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import Foundation
import Moya



class AddPostViewModel {
    
    fileprivate let provider: MoyaProvider<PostsEndpoint>
    fileprivate let validator: PostValidator
    
    init(provider: MoyaProvider<PostsEndpoint>, postFieldsValidator: PostValidator) {
        self.provider = provider
        self.validator = postFieldsValidator
    }
    
    var title: String {
        return "Add new post"
    }
    
    
    var allFieldsAreValid: Bool {
        return  titleField.validationStatus == .correct &&
                bodyField.validationStatus == .correct
    }
    
    struct FieldValidated {
        var text: String = ""
        var validationStatus: ValidationStatus = .empty {
            didSet {
                onValidationStatusChange?(validationStatus.message)
            }
        }

        var onValidationStatusChange: ((String) -> Void)?
        init(onValidationStatusChange: ((String) -> Void)?) {
            self.onValidationStatusChange = onValidationStatusChange
        }
    }
    
    lazy var titleField: FieldValidated = {
        return FieldValidated(onValidationStatusChange: self.didTitleValidationStatusChanged)
    }()
    
    lazy var bodyField: FieldValidated = {
        return FieldValidated(onValidationStatusChange: self.didBodyValidationStatusChanged)
    }()
    
    
    var didTitleValidationStatusChanged: ((String) -> Void)?
    var didBodyValidationStatusChanged: ((String) -> Void)?
    var didValidationStatusUpdated: ((Bool) -> Void)?
    var didEncounterErrorWhileSaving: ((String) -> Void)?
    
    var didSavePost: (() -> Void)?
    
    
    func validate(title: String) {
        validator.validate(title: title) { (title, status) in
            titleField.text = title
            titleField.validationStatus = status
            didValidationStatusUpdated?(allFieldsAreValid)
        }
    }
    
    
    func validate(body: String) {
        validator.validate(body: body) { (body, status) in
            bodyField.text = body
            bodyField.validationStatus = status
            didValidationStatusUpdated?(allFieldsAreValid)
        }
    }
    
    
    
    func saveCar() {
        
        let post = Post(id: 0, userId: 3, title: titleField.text, body: bodyField.text)
        
        provider.request(.addPost(post: post)) { [weak self] (result) in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                
                switch statusCode {
                case 400...499:
                    self?.didEncounterErrorWhileSaving?(PostsListError.clientError(code: statusCode).message)
                case 500...599:
                    self?.didEncounterErrorWhileSaving?(PostsListError.serverError(code: statusCode).message)
                case 201:
                    self?.didSavePost?()
                default: break
                }
                print(statusCode)
            case let .failure(error):
                print("ERROR: \(error.localizedDescription)")
                self?.didEncounterErrorWhileSaving?(error.localizedDescription)
            }
        }
    }
    
}
