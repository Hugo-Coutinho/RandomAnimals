//
//  DogServiceTests.swift
//  RandomAnimalsTests
//
//  Created by BRQ on 31/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import XCTest
@testable import RandomAnimals

class DogServiceTests: XCTestCase {
    
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
        XCTAssertNotNil(self.dogImage)
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

//MARK: - INTERACTOR OUTPUT -
extension DogServiceTests: DogInteractorOutput {
    func downloadDog(dogImage: UIImage?) {
        guard let dogImage = dogImage else { self.responseState = false; return }
        self.dogImage = dogImage
        self.responseState = true
    }
    
    func responseDidFail() {
        self.responseState = false
    }
}
