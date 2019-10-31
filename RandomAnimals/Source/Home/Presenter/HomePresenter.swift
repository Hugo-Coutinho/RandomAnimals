//
//  HomePresenter.swift
//  RandomAnimals
//
//  Created by BRQ on 28/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

protocol HomePresenterInput {
    var viewDelegate: HomePresenterOutput? { get set }
    static func make(viewDelegate: HomePresenterOutput, interactor: DogInteractorInput) -> HomePresenterInput
    static func make(interactor: DogInteractorInput) -> HomePresenterInput
    func fetchDog()
}

protocol HomePresenterOutput {
    func successVisibility(dogImage: UIImage)
    func loadingvisibility()
    func failureVisibility()
}


final class HomePresenter: HomePresenterInput {
    
    var viewDelegate: HomePresenterOutput?
    var interactor: DogInteractorInput?
    
    init(viewDelegate: HomePresenterOutput, interactor: DogInteractorInput) {
        self.viewDelegate = viewDelegate
        self.interactor = interactor
        self.interactor?.delegate = self
    }
    
    init(interactor: DogInteractorInput) {
        self.interactor = interactor
    }
    
    static func make(viewDelegate: HomePresenterOutput, interactor: DogInteractorInput) -> HomePresenterInput {
        return HomePresenter.init(viewDelegate: viewDelegate, interactor: interactor)
    }
    
    static func make(interactor: DogInteractorInput) -> HomePresenterInput {
        return HomePresenter.init(interactor: interactor)
    }
    
    func fetchDog() {
        self.interactor?.getDog()
    }
}

extension HomePresenter: DogInteractorOutput {    
    func downloadDog(dogImage: UIImage?) {
        guard let dogImage = dogImage else { self.viewDelegate?.failureVisibility(); return }
        self.viewDelegate?.successVisibility(dogImage: dogImage)
    }
}
