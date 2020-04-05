//
//  Cat.swift
//  RandomAnimals
//
//  Created by Hugo on 19/11/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation

struct Cat: BaseAnimalProtocol {
    var url: String
}

extension Cat: Codable { }
