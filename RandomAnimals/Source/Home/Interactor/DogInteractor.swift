//
//  DogInteractor.swift
//  RandomAnimals
//
//  Created by BRQ on 27/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol DogInteractorInput {
    var delegate: DogInteractorOutput? { get set }
    static func make(service: DogServiceInput) -> DogInteractorInput
    func getDog()
}

protocol DogInteractorOutput {
    func downloadDog(dogImage: UIImage?)
}

class DogInteractor: DogInteractorInput {
    
    //MARK: - DECLARATIONS -
    var service: DogServiceInput?
    var delegate: DogInteractorOutput?
    
    //MARK: - INITIALIZATION -
    init(service: DogServiceInput) {
        self.service = service
    }
    
    //MARK: - METHODS -
    static func make(service: DogServiceInput) -> DogInteractorInput {
      return DogInteractor.init(service: service)
    }
    
    func getDog() {
        self.service?.getDog(successCompletion: { (result) in
                self.downloadDogImage(url: result["url"] as? String ?? "")
        }, errorCompletion: { () in
            self.delegate?.downloadDog(dogImage: nil)
        })
    }
    
    func downloadDogImage(url: String) {
        if let url:URL = URL(string: url) {
            let imageView = UIImageView()
            let resource = ImageResource(downloadURL: url)
            
            imageView.kf.setImage(with: resource, options: nil, completionHandler: { (image, _, _, _) in
                    self.delegate?.downloadDog(dogImage: image)
            })
        } else {
            self.delegate?.downloadDog(dogImage: nil)
        }
    }
}

//MARK: - SERVICE OUTPUT -
extension DogInteractor: DogServiceOutput {
    func didFail() {
        self.delegate?.downloadDog(dogImage: nil)
    }
}
