//
//  UserService.swift
//  Demo002
//
//  Created by Julio Collado Perez on 4/30/23.
//

import Foundation
import Combine

protocol UserServiceInterface {
    var usersPublisher: PassthroughSubject<[UserDTO], Error> { get }
    init(networkManager: NetworkManagerInterface)
    
    func requestUsers()
}

class UserService: UserServiceInterface {
    var usersPublisher = PassthroughSubject<[UserDTO], Error>()
    
    private let networkManager: NetworkManagerInterface
    private var cancellables = Set<AnyCancellable>()
    
    required init(networkManager: NetworkManagerInterface = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func requestUsers() {
        guard let baseURL = URL(string: BaseURLConstants.usersBaseURL),
              let fullURL = getURLRequest(request: HTTPRequest(baseURL: baseURL, path: "/users")) else {
            self.usersPublisher.send(completion: .failure(RequestError.badURL))
            return
        }
        
        networkManager.request(url: fullURL, qos: nil)
            .decode(type: [UserDTO].self, decoder: JSONDecoder())
            .sink { completion in
                self.usersPublisher.send(completion: completion)
            } receiveValue: { users in
                self.usersPublisher.send(users)
            }
            .store(in: &cancellables)
    }
    
    private func getURLRequest(request: HTTPRequest) -> URL? {
        guard var components = URLComponents(url: request.baseURL, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.path = request.path
        return components.url
    }
}
