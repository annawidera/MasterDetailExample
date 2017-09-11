//
//  ObjectMapper+Contains.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 11.07.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import Foundation
import ObjectMapper

extension Map {
    
    func contains(keys: [String]) -> Bool {
        guard keys.count > 0 else {
            return true
        }
        
        return keys.reduce(true) { (result, key) -> Bool in
            result && self[key].isKeyPresent
        }
    }
}
