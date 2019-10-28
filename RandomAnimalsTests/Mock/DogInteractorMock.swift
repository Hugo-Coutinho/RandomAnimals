//
//  DogInteractorMock.swift
//  RandomAnimalsTests
//
//  Created by BRQ on 28/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

class DogInteractorMock: DogInteractorInput {
    
    enum DonwloadState {
        case sucess
        case failure
    }
    
    var delegate: DogInteractorOutput?
    var downloadState: DonwloadState = .sucess
    
    static func make(service: DogServiceInput) -> DogInteractorInput {
        return DogInteractor.init(service: service)
    }
    
    func downloadDogImageMock() {
        switch downloadState {
        case .sucess:
            self.delegate?.downloadDog(dogImage: UIImage())
        case .failure:
            self.delegate?.downloadDog(dogImage: nil)
        }
    }
    
    func getDog() {
        self.downloadDogImageMock()
    }
}
