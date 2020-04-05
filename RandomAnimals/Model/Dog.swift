//
//  Dog.swift
//  RandomAnimals
//
//  Created by Hugo on 27/10/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation

struct Dog: BaseAnimalProtocol {
    var url: String
}

extension Dog: Codable {
    private enum CodingKeys : String, CodingKey {
        case url = "message"
    }
}
