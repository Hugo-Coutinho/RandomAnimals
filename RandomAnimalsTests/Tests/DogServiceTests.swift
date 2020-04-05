//
//  DogServiceTests.swift
//  RandomAnimalsTests
//
//  Created by Hugo on 31/10/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import XCTest
@testable import RandomAnimals

class DogServiceTests: XCTestCase {
    
    //MARK: - DECLARATIONS -
    var service: DogServiceMock!
    
    override func setUp() {
        super.setUp()
        self.service = DogServiceMock()
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
    }
    
    func testDogServiceSucess() {
        // 2. WHEN
        self.service.status = .success
        
        // 3. THEN
        assert(self.networkConnectionIsOk())
        self.service.getAnimalByPath(path: "", successCompletion: { (url) in
            assert(url == HomeTestsConstant.dogName)
        }) {
            assertionFailure()
        }
    }
    
    func testCatServiceFailure() {
        // 2. WHEN
        self.service.status = .error
        
        service.getAnimalByPath(path: "", successCompletion: { (successAny) in
            // 3. THEN
            assertionFailure()
        }) {
            
            XCTAssertTrue(true)
        }
    }
}

//MARK: - AUX METHODS -
extension DogServiceTests {
    private func networkConnectionIsOk() -> Bool {
        guard Reachability.isConnectedToNetwork() else { return false }
        return true
    }
}
