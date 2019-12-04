//
//  CatService.swift
//  RandomAnimals
//
//  Created by BRQ on 19/11/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import Alamofire

class CatService: FetchAnimalInput {
    func getAnimalByPath(path: String, successCompletion: @escaping (_ animalPath: String) -> Void, errorCompletion: @escaping () -> Void) {
        BaseRequest(router: path) { (result: Result<Cat>) in
            if result.isSuccess {
                guard let cat = result.value else { errorCompletion(); return }
                successCompletion(cat.url)
            } else {
                errorCompletion()
            }
        }
    }
}
