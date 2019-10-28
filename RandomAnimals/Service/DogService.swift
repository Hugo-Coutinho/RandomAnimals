//
//  DogService.swift
//  RandomAnimals
//
//  Created by BRQ on 27/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import Alamofire

protocol DogServiceInput {
    var delegate: DogServiceOutput? { get set }
    func getDog(successCompletion: @escaping ([String: Any]) -> Void, errorCompletion: @escaping () -> Void)
    
}

protocol DogServiceOutput {
    func didFail()
}

class DogService: DogServiceInput {
    
    var delegate: DogServiceOutput?
    
    func getDog(successCompletion: @escaping ([String: Any]) -> Void, errorCompletion: @escaping () -> Void) {
        let path = "https://dog.ceo/api/breeds/image/random"
        
        Alamofire.request(path, method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .validate(statusCode:  200..<300).responseJSON {(response) -> Void in
                do {
                    guard let message = response.result.value else { errorCompletion(); return }
                    successCompletion(["message": message])
                } catch {
                    errorCompletion()
                }
        }
    }
}
