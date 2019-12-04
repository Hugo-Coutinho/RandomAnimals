//
//  DogPresenterTests.swift
//  RandomAnimalsTests
//
//  Created by BRQ on 31/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import XCTest
@testable import RandomAnimals

class HomePresenterTests: XCTestCase {

    //MARK: - DECLARATIONS -
    var responseState: Bool = false
    var animalImage: UIImage? = nil
    var animalType: AnimalType? = nil

    
    override func setUp() {
        super.setUp()
        self.responseState = false
        self.animalImage = nil
        self.animalType = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.responseState = false
        self.animalImage = nil
        self.animalType = nil
    }

    func testFetchDog_ShouldImageNotNilAndAnimalTypeEqualsToDog() {
        // 1. GIVEN
        let interactor = DogInteractorMock()
        var presenter = HomePresenter.make(viewDelegate: self)
        presenter.viewDelegate = self
        presenter.interactor = interactor
        presenter.interactor?.delegate = self
        
        // 2. WHEN
        presenter.fetchCurrentAnimalby(index: AnimalType.dog.rawValue)
        
        // 3. THEN
        XCTAssertNotNil(self.animalImage)
        XCTAssertNotNil(self.animalType)
        assert(self.animalType == AnimalType.dog)
    }
    
    func testFetchDog_ShouldImageNotNilAndAnimalTypeEqualsToCat() {
        // 1. GIVEN
        let interactor = DogInteractorMock()
        var presenter = HomePresenter.make(viewDelegate: self)
        presenter.viewDelegate = self
        presenter.interactor = interactor
        presenter.interactor?.delegate = self
        
        // 2. WHEN
        presenter.fetchCurrentAnimalby(index: AnimalType.cat.rawValue)
        
        // 3. THEN
        XCTAssertNotNil(self.animalImage)
        XCTAssertNotNil(self.animalType)
        assert(self.animalType == AnimalType.cat)
    }
    
    func testAnimalSegmentIndex_ShouldProvideDogService() {
        // 1. GIVEN
        let presenter = HomePresenter.make(viewDelegate: self)
        
        // 2. WHEN
        // 3. THEN
        guard let service = presenter.makeInteractor(animalSegment: 0).service else { assertionFailure(); return }
        assert(service is DogService)
    }
    
    func testAnimalSegmentIndex_ShouldProvideCatService() {
        // 1. GIVEN
        let presenter = HomePresenter.make(viewDelegate: self)
        
        // 2. WHEN
        // 3. THEN
        guard let service = presenter.makeInteractor(animalSegment: 1).service else { assertionFailure(); return }
        assert(service is CatService)
    }
}

//MARK: - PRESENTER OUTPUT -
extension HomePresenterTests: HomePresenterOutput {
    func successVisibility(dogImage: UIImage) {
        self.animalImage = dogImage
    }
    
    func loadingvisibility() {
        self.animalImage = nil
    }
    
    func failureVisibility() {
        self.animalImage = nil
    }
}


//MARK: - INTERACTOR OUTPUT -
extension HomePresenterTests: HomeInteractorOutput {
    func downloadAnimal(image: UIImage?, animalType: AnimalType?) {
        guard let image = image else { self.responseState = false; return }
        self.animalImage = image
        self.animalType = animalType
        self.responseState = true
    }
}




