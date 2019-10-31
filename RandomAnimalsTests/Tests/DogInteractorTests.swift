//
//  DogInteractorTests.swift
//  RandomAnimalsTests
//
//  Created by BRQ on 31/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import XCTest
@testable import RandomAnimals

class DogInteractorTests: XCTestCase {
    
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
extension DogInteractorTests: DogInteractorOutput {
    func downloadDog(dogImage: UIImage?) {
        guard let dogImage = dogImage else { self.responseState = false; return }
        self.dogImage = dogImage
        self.responseState = true
    }
    
    func responseDidFail() {
        self.responseState = false
    }
}
