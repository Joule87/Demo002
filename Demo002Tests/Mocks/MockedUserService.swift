//
//  MockedUserService.swift
//  Demo002Tests
//
//  Created by Julio Collado Perez on 5/3/23.
//

import Foundation
import Combine
@testable import Demo002

struct MockedUserService: UserServiceInterface {
    var usersPublisher = PassthroughSubject<[UserDTO], Error>()
    var mockedGetUserResponse: (users: [UserDTO]?, error: Error?)
    
    init(networkManager: NetworkManagerInterface) {
        
    }
    
    init(mockedGetUserResponse: ([UserDTO]?, Error?)) {
        self.mockedGetUserResponse = mockedGetUserResponse
    }
    
    func requestUsers() {
        if let error = mockedGetUserResponse.error {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.usersPublisher.send(completion: .failure(error))
            }
            return
        }
        if let users = mockedGetUserResponse.users {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.usersPublisher.send(users)
            }
            return
        }
    }
}
