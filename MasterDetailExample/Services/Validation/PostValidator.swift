//
//  PostValidator.swift
//  MasterDetailExample
//
//  Created by Ania Widera on 11.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import Foundation

class PostValidator: PostValidatorProtocol {
    
    func validate(title: String, completionHandler: (String, ValidationStatus) -> Void)  {
        validate(text: title, completionHandler: completionHandler)
    }
    
    func validate(body: String, completionHandler: (String, ValidationStatus) -> Void)  {
        
        if body.characters.count == 0 {
            completionHandler(body, .empty)
            return
        }
        completionHandler(body, .correct)
    }

    
    
    //MARK: - Helpers
    
    func validate(text: String, completionHandler: (String, ValidationStatus) -> Void) {
        
        if text.characters.count == 0 {
            completionHandler(text, .empty)
            return
        }
        
        if text.characters.count < 4 {
            completionHandler(text, .tooShort)
            return
        }
        completionHandler(text, .correct)
    }
}
