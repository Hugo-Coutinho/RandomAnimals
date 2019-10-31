//
//  DogPresenterTests.swift
//  RandomAnimalsTests
//
//  Created by BRQ on 31/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import XCTest
@testable import RandomAnimals

class DogPresenterTests: XCTestCase {

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
extension DogPresenterTests: HomePresenterOutput {
    func successVisibility(dogImage: UIImage) {
        self.dogImage = dogImage
    }
    
    func loadingvisibility() {
        self.dogImage = nil
    }
    
    func failureVisibility() {
        self.dogImage = nil
    }
}


//MARK: - INTERACTOR OUTPUT -
extension DogPresenterTests: DogInteractorOutput {
    func downloadDog(dogImage: UIImage?) {
        guard let dogImage = dogImage else { self.responseState = false; return }
        self.dogImage = dogImage
        self.responseState = true
    }
    
    func responseDidFail() {
        self.responseState = false
    }
}




