//
//  BaseRequest.swift
//  RandomAnimals
//
//  Created by BRQ on 16/11/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Alamofire
import Foundation

enum RequestError: Error {
    case Failure()
}

protocol FetchAnimalInput {
    func getAnimalByPath(path: String, successCompletion: @escaping (_ animalPath: String) -> Void, errorCompletion: @escaping () -> Void)
}

struct BaseRequest {
    @discardableResult
    init<T: Decodable>(router: String, completion: @escaping (Result<T>) -> Void) {
        Alamofire.request(router, method: .get).validate(statusCode: 200..<300).responseJSON { response in
            guard response.error == nil,
                let responseValue = response.value,
                let responseValueAsData = try? JSONSerialization.data(withJSONObject: responseValue, options: [])
            else { completion(Result.failure(RequestError.Failure())); return }
            do {
                let element = try JSONDecoder().decode(T.self, from: responseValueAsData)
                completion(Result.success(element))
            } catch {
                completion(Result.failure(RequestError.Failure()))
            }
        }
    }
}

