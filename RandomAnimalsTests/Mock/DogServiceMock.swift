//
//  DogServiceMock.swift
//  RandomAnimalsTests
//
//  Created by BRQ on 27/10/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
@testable import RandomAnimals

final class DogServiceMock: DogServiceInput {

    enum DogServiceStatus {
        case success
        case error
    }
    
    var delegate: DogServiceOutput?
    var status: DogServiceStatus = .success
    
    func getDog(successCompletion: @escaping ([String: Any]) -> Void, errorCompletion: @escaping () -> Void) {
        switch self.status {
        case .success:
            successCompletion(["message": HomeTestsConstant.dogName])
            
        case .error:
            errorCompletion()
        }
    }
}
