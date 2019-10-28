//
//  DogInteractor.swift
//  RandomAnimals
//
//  Created by BRQ on 27/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation

protocol DogInteractorOutput {
    func success(dogImageUrl: String)
    func didFail()
}

class DogInteractor {
    
    var service: DogServiceInput?
    var delegate: DogInteractorOutput?
    
    init(service: DogServiceInput) {
        self.service = service
    }
    
    func getDog() {
        self.service?.getDog(successCompletion: { (result) in
            if let message = result["message"] as? String,
                message.elementsEqual("July") {
                self.delegate?.success(dogImageUrl: message)
            } else {
                self.delegate?.didFail()
            }
        }, errorCompletion: { () in
            self.delegate?.didFail()
        })
    }
}

extension DogInteractor: DogServiceOutput {
    func didFail() {
        self.delegate?.didFail()
    }
}
