//
//  DogService.swift
//  RandomAnimals
//
//  Created by BRQ on 27/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import Alamofire

class DogService: FetchAnimalInput {
     func getAnimalByPath(path: String, successCompletion: @escaping (_ animalPath: String) -> Void, errorCompletion: @escaping () -> Void) {
        BaseRequest(router: path) { (result: Result<Cat>) in
            if result.isSuccess {
                guard let dog = result.value else { errorCompletion(); return }
                successCompletion(dog.url)
            } else {
                errorCompletion()
            }
        }
    }
}
