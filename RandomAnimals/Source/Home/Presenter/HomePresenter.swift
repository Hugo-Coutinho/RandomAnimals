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
    var interactor: HomeInteractorInput? { get set }
    static func make(viewDelegate: HomePresenterOutput) -> HomePresenterInput
    func fetchCurrentAnimalby(index: Int)
    func makeInteractor(animalSegment: Int) ->  HomeInteractorInput
}

protocol HomePresenterOutput {
    func successVisibility(dogImage: UIImage)
    func loadingvisibility()
    func failureVisibility()
}

enum AnimalType: Int {
    case dog = 0
    case cat = 1
}

final class HomePresenter: HomePresenterInput {
    
    var viewDelegate: HomePresenterOutput?
    var interactor: HomeInteractorInput?
    
    init(viewDelegate: HomePresenterOutput? = nil) {
        self.viewDelegate = viewDelegate
        self.interactor = self.makeInteractor(animalSegment: 0)
        self.interactor?.delegate = self
    }
    
    static func make(viewDelegate: HomePresenterOutput) -> HomePresenterInput {
        return HomePresenter.init(viewDelegate: viewDelegate)
    }
    
    func fetchCurrentAnimalby(index: Int) {
        switch index {
        case 0:
            self.interactor?.service = DogService()
            self.fetchAnimal(animalType: AnimalType.dog)
        case 1:
            self.interactor?.service = CatService()
            self.fetchAnimal(animalType: AnimalType.cat)
        default:
            break;
        }
    }
    
    func makeInteractor(animalSegment: Int) -> HomeInteractorInput {
        switch animalSegment {
        case 0:
            return HomeInteractor.make(service: DogService())
        default:
            return HomeInteractor.make(service: CatService())
        }
    }
}

//MARK: - AUX Methods -
extension HomePresenter {
    private func fetchAnimal(animalType: AnimalType) {
        self.interactor?.getAnimalBy(type: animalType)
    }
}

//MARK: - INTERACTOR OUTPUT -
extension HomePresenter: HomeInteractorOutput {
    func downloadAnimal(image: UIImage?, animalType: AnimalType?) {
        guard let dogImage = image else { self.viewDelegate?.failureVisibility(); return }
        self.viewDelegate?.successVisibility(dogImage: dogImage)
    }
}
