//
//  UsersServiceUnitTests.swift
//  Demo002Tests
//
//  Created by Julio Collado Perez on 5/1/23.
//

import Foundation
import XCTest
import Combine
@testable import Demo002

class UsersServiceUnitTests: XCTestCase {
    var userService: UserService!
    var cancellable: AnyCancellable?
    
    override func tearDownWithError() throws {
        userService = nil
        cancellable = nil
    }
    
    func testRequestUsersSucceeded() throws {
        // 1 - Given
        let networkManager = MockNetworkManager(json: MockUsers.userListJSON)
        userService = UserService(networkManager: networkManager)
        
        // 3 - Then
        cancellable = userService.usersPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("❌ \(error.localizedDescription)")
                }
            } receiveValue: { users in
                XCTAssertEqual(MockUsers.userList, users)
            }
        
        // 2 - When
        userService.requestUsers()
    }
    
    func testRequestUsersFailed() throws {
        // 1 - Given
        let networkManager = MockNetworkManager(json: nil)
        userService = UserService(networkManager: networkManager)
        
        // 3 - Then
        cancellable = userService.usersPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    guard let requestError = error as? RequestError else {
                        XCTFail("❌ not defined error")
                        return
                    }
                    if case .unknown = requestError {
                        XCTAssert(true)
                    }
                }
            } receiveValue: { users in
                XCTFail("❌ \(users)")
            }
        
        // 2 - When
        userService.requestUsers()
    }
}

extension UserDTO: Equatable {
    public static func == (lhs: UserDTO, rhs: UserDTO) -> Bool {
        lhs.id == rhs.id && lhs.email == rhs.email
    }
}
