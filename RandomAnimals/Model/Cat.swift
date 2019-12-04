//
//  Cat.swift
//  RandomAnimals
//
//  Created by BRQ on 19/11/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation

struct Cat: BaseAnimalProtocol {
    var url: String
}

extension Cat: Codable { }
