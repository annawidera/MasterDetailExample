//
//  PostValidationProtocol.swift
//  MasterDetailExample
//
//  Created by Ania Widera on 11.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import Foundation


enum ValidationStatus {
    case correct
    case empty
    case tooShort
    case spacesNotAllowed
    case invalid
    
    var message: String {
        switch self {
        case .correct: return ""
        case .empty: return "required"
        case .tooShort: return "too short"
        case .spacesNotAllowed: return "remove spaces"
        case .invalid: return "invalid"
        }
    }
}


protocol PostValidatorProtocol {
    func validate(title: String, completionHandler: (String, ValidationStatus) -> Void)
    func validate(body: String, completionHandler: (String, ValidationStatus) -> Void)
}
