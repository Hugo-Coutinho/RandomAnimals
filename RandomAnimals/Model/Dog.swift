//
//  Dog.swift
//  RandomAnimals
//
//  Created by BRQ on 27/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation

class Dog {
    var message: String?
    
    init(attributes: [String: Any]) {
         self.message = attributes["message"] as? String
    }
}
