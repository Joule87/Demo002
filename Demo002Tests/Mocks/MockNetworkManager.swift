//
//  MockNetworkManager.swift
//  Demo002Tests
//
//  Created by Julio Collado Perez on 5/2/23.
//

import Foundation
import XCTest
import Combine
@testable import Demo002

class MockNetworkManager: NetworkManagerInterface {
    var json: String?
    
    init(json: String?) {
        self.json = json
    }
    
    func request(url: URL, qos: DispatchQoS.QoSClass?) -> AnyPublisher<Data, Error> {
        guard let unwrappedJSON = json,
              let data = unwrappedJSON.data(using: .utf8) else {
            debugPrint("❌ \(#function) failed")
            return Fail(error: RequestError.unknown).eraseToAnyPublisher()
        }
        debugPrint("✅ \(#function) succeeded")
        return Just(data)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
