//
//  HomeTests.swift
//  RandomAnimalsTests
//
//  Created by BRQ on 27/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import XCTest
@testable import RandomAnimals

class HomeTests: XCTestCase {
    
    //MARK: - DECLARATIONS -
    var responseState: Bool = false
    var dogImage: UIImage? = nil
}

//MARK: - OVERRIDE -
extension HomeTests {
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
}


//MARK: - SERVICE TESTS -
extension HomeTests {
        
    func testAttributes() {
        // 1. GIVEN
        let attributes: [String : Any] = ["message": HomeTestsConstant.dogName]
        
        // 2. WHEN
        let dog = Dog(attributes: attributes)
        
        // 3. THEN
        XCTAssertEqual(dog.message, HomeTestsConstant.dogName)
    }
    
    func testServiceSucess() {
        // 1. GIVEN
        let interactor = DogInteractorMock()
        interactor.delegate = self
        
        // 2. WHEN
        interactor.getDog()
        
        // 3. THEN
        XCTAssertTrue(self.responseState)
    }
    
    func testServiceFailure() {
        // 1. GIVEN
        let slMock = DogServiceMock()
        let interactor = DogInteractor(service: slMock)
        interactor.delegate = self
        
        // 2. WHEN
        slMock.status = .error
        interactor.getDog()
        
        // 3. THEN
        XCTAssertFalse(self.responseState)
    }
}

//MARK: - INTERACTOR TESTS -
extension HomeTests {
    func testDownloadImageSuccess() {
        // 1. GIVEN
        let interactor = DogInteractorMock()
        interactor.delegate = self
        
        // 2. WHEN
        interactor.downloadDogImageMock()
        
        // 3. THEN
        XCTAssertNotNil(self.dogImage)
    }
    
    func testDownloadImageError() {
        // 1. GIVEN
        let interactor = DogInteractorMock()
        interactor.delegate = self
        
        // 2. WHEN
        interactor.downloadState = .failure
        interactor.downloadDogImageMock()
        
        // 3. THEN
        XCTAssertNil(self.dogImage)
    }
}

//MARK: - INTERACTOR OUTPUT -
extension HomeTests: DogInteractorOutput {
    func downloadDog(dogImage: UIImage?) {
        self.dogImage = dogImage
        self.responseState = true
    }

    func responseSuccess(dogImageUrl: String) {
        self.responseState = true
    }

    func responseDidFail() {
     self.responseState = false
    }
}

//MARK: - PRESENTER TESTS -
extension HomeTests {
    func testPresenterFecthDogSuccess() {
        // 1. GIVEN
        let interactor = DogInteractorMock()
        var presenter = HomePresenter.make(interactor: interactor)
        presenter.viewDelegate = self
        interactor.delegate = self
        
        // 2. WHEN
        presenter.fetchDog()
        
        // 3. THEN
        XCTAssertNotNil(self.dogImage)
    }
}

//MARK: - PRESENTER OUTPUT -
extension HomeTests: HomePresenterOutput {
    func successVisibility(dogImage: UIImage) {
        self.dogImage = dogImage
    }
    
    func loadingvisibility() {
        
    }
    
    func failureVisibility() {
        self.dogImage = nil
    }
}



