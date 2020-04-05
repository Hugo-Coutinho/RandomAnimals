//
//  DogInteractor.swift
//  RandomAnimals
//
//  Created by Hugo on 27/10/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol HomeInteractorInput {
    var delegate: HomeInteractorOutput? { get set }
    var animalType: AnimalType? { get set }
    var service: FetchAnimalInput? { get set }
    static func make(service: FetchAnimalInput) -> HomeInteractorInput
    func getAnimalBy(type: AnimalType)
}

protocol HomeInteractorOutput {
    func downloadAnimal(image: UIImage?, animalType: AnimalType?)
}

class HomeInteractor: HomeInteractorInput {
    
    //MARK: - DECLARATIONS -
    var animalType: AnimalType?
    var service: FetchAnimalInput?
    var delegate: HomeInteractorOutput?
    
    //MARK: - INITIALIZATION -
    init(service: FetchAnimalInput) {
        self.service = service
    }
    
    //MARK: - METHODS -
    static func make(service: FetchAnimalInput) -> HomeInteractorInput {
      return HomeInteractor.init(service: service)
    }
    
    func getAnimalBy(type: AnimalType) {
        self.animalType = .cat
        self.service?.getAnimalByPath(path: self.getUrlBy(animalType: type), successCompletion: { (animalPath) in
                self.downloadDogImage(url: animalPath)
        }, errorCompletion: { () in
            self.delegate?.downloadAnimal(image: nil, animalType: self.animalType)
        })
    }
    
    private func downloadDogImage(url: String) {
        if let url:URL = URL(string: url) {
            let imageView = UIImageView()
            let resource = ImageResource(downloadURL: url)
            
            imageView.kf.setImage(with: resource, options: nil, completionHandler: { (image, _, _, _) in
                    self.delegate?.downloadAnimal(image: image, animalType: self.animalType)
            })
        } else {
            self.delegate?.downloadAnimal(image: nil, animalType: self.animalType)
        }
    }
}

//MARK: - AUX METHODS -
extension HomeInteractor {
    func getUrlBy(animalType: AnimalType) -> String {
        switch animalType {
        case .cat:
            return HomeTestsConstant.apiCat
        case .dog:
            return HomeTestsConstant.apiDog
        }
    }
}
