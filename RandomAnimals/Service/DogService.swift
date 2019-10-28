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
        let path = HomeTestsConstant.apiDog
        
        Alamofire.request(path, method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .validate(statusCode:  200..<300).responseJSON {(response) -> Void in
                do {
                    let message = response.result.value as AnyObject
                    guard let dogURL = message["message"] else { errorCompletion(); return }
                    successCompletion(["url": (dogURL as? String)])
                } catch {
                    errorCompletion()
                }
        }
    }
}
