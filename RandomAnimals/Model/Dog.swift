//
//  Dog.swift
//  RandomAnimals
//
//  Created by BRQ on 27/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
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
