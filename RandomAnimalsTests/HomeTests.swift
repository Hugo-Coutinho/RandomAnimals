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
    
    var responseState: Bool = false

    override func setUp() {
        super.setUp()
        self.responseState = false
    }

    override func tearDown() {
        super.tearDown()
        self.responseState = false
    }
    
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
        let slMock = DogServiceMock()
        let interactor = DogInteractor(service: slMock)
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

extension HomeTests: DogInteractorOutput {
    func success(dogImageUrl: String) {
        self.responseState = true
    }

    func didFail() {
     self.responseState = false
    }
}
