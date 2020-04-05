//
//  DogInteractorTests.swift
//  RandomAnimalsTests
//
//  Created by Hugo on 31/10/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import XCTest
@testable import RandomAnimals

class HomeInteractorTests: XCTestCase {
    
    //MARK: - DECLARATIONS -
    var responseState: Bool = false
    var dogImage: UIImage? = nil
    
    override func setUp() {
        super.setUp()
        self.responseState = false
        self.dogImage = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.responseState = false
        self.dogImage = nil
    }
    
    func testDownloadImageSuccess() {
        // 1. GIVEN
        let interactor = DogInteractorMock()
        interactor.delegate = self
        
        // 2. WHEN
        interactor.downloadState = .success
        interactor.downloadDogImageMock(animalType: nil)
        
        // 3. THEN
        XCTAssertNotNil(self.dogImage)
        assert(self.responseState)
    }
    
    func testDownloadImageError() {
        // 1. GIVEN
        let interactor = DogInteractorMock()
        interactor.delegate = self
        
        // 2. WHEN
        interactor.downloadState = .failure
        interactor.downloadDogImageMock(animalType: nil)
        
        // 3. THEN
        XCTAssertNil(self.dogImage)
        XCTAssertFalse(self.responseState)
    }
    
    func testResultOfgetUrlByAnimal_ShouldReturnApiCat() {
        // 1. GIVEN
        let serviceMock = DogServiceMock()
        let homeInteractor = HomeInteractor(service: serviceMock)
        
        // 2. WHEN
        // 3. THEN
        assert(homeInteractor.getUrlBy(animalType: .cat).elementsEqual(HomeTestsConstant.apiCat))
    }
    
    func testResultOfgetUrlByAnimal_ShouldReturnApiDog() {
        // 1. GIVEN
        let serviceMock = DogServiceMock()
        let homeInteractor = HomeInteractor(service: serviceMock)
        
        // 2. WHEN
        // 3. THEN
        assert(homeInteractor.getUrlBy(animalType: .dog).elementsEqual(HomeTestsConstant.apiDog))
    }
}

//MARK: - INTERACTOR OUTPUT -
extension HomeInteractorTests: HomeInteractorOutput {
    func downloadAnimal(image: UIImage?, animalType: AnimalType?) {
        self.dogImage = image
        guard let _ = image else { self.responseState = false; return }
        self.responseState = true
    }
}
