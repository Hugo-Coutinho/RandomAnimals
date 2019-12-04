//
//  DogInteractorMock.swift
//  RandomAnimalsTests
//
//  Created by BRQ on 28/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

class DogInteractorMock: HomeInteractorInput {
    var service: FetchAnimalInput?
    
    
    enum DonwloadState {
        case success
        case failure
    }
    
    var animalType: AnimalType?
    var delegate: HomeInteractorOutput?
    var downloadState: DonwloadState = .success
    
    static func make(service: FetchAnimalInput) -> HomeInteractorInput {
        return HomeInteractor.init(service: service)
    }
    
    func downloadDogImageMock(animalType: AnimalType?) {
        switch downloadState {
        case .success:
            self.delegate?.downloadAnimal(image: UIImage(), animalType: animalType)
        case .failure:
            self.delegate?.downloadAnimal(image: nil, animalType: nil)
        }
    }
    
    func getAnimalBy(type: AnimalType) {
        self.downloadDogImageMock(animalType: type)
    }
}
