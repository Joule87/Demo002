//
//  NetworkManager.swift
//  Demo002
//
//  Created by Julio Collado Perez on 4/30/23.
//

import Foundation
import Combine

protocol NetworkManagerInterface {
    func request(url: URL, qos: DispatchQoS.QoSClass?) -> AnyPublisher<Data, Error>
}

struct NetworkManager: NetworkManagerInterface {
    func request(url: URL, qos: DispatchQoS.QoSClass?) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: qos ?? .default))
            .tryMap(handleURLResponse)
            .eraseToAnyPublisher()
    }
    
    
    private func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            debugPrint("❌ request failed: \((output.response as? HTTPURLResponse)?.statusCode ?? 0)")
            throw RequestError.badResponse(url: output.response.url!, statusCode: (output.response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        debugPrint("✅ request succeeded: \(output.response.url?.absoluteString ?? "")")
        return output.data
    }
}
