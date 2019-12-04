//
//  DogServiceMock.swift
//  RandomAnimalsTests
//
//  Created by BRQ on 27/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
@testable import RandomAnimals

final class DogServiceMock: FetchAnimalInput {
    enum DogServiceStatus {
        case success
        case error
    }
    
    var status: DogServiceStatus = .success
    
    func getAnimalByPath(path: String, successCompletion: @escaping (String) -> Void, errorCompletion: @escaping () -> Void) {
        switch self.status {
        case .success:
            successCompletion(HomeTestsConstant.dogName)
            
        case .error:
            errorCompletion()
        }
    }
}
