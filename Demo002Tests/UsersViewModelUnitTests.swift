//
//  UsersViewModelUnitTests.swift
//  Demo002Tests
//
//  Created by Julio Collado Perez on 5/2/23.
//

import XCTest
import Combine
@testable import Demo002

final class UsersViewModelUnitTests: XCTestCase {
    
    var cancellable: AnyCancellable?
    var viewModel: UsersViewModel!
    var expectation: XCTestExpectation!
    
    override func tearDownWithError() throws {
        cancellable = nil
        viewModel = nil
        expectation = nil
    }
    
    override func setUpWithError() throws {
        expectation = XCTestExpectation(description: "should return users after 1 second")
    }
    
    /// test_Unit of work _ State Under test _ Expected behaviour
    func test_GetUsers_Succeeded() {
        // 1 - Given
        let usersDataService = MockedUserService(mockedGetUserResponse: (MockUsers.userList, nil))
        viewModel = UsersViewModel(usersService: usersDataService)
        
        // 2 - When
        cancellable = viewModel.$users
            .dropFirst()
            .sink(receiveValue: { [weak self] _ in
                self?.expectation.fulfill()
            })
        
        viewModel.getUsers()
        
        // 3 - Then
        wait(for: [expectation], timeout: 2)
        XCTAssertGreaterThan(viewModel.users.list?.count ?? 0, 0)
    }
    
    func test_GetUsers_Failed() {
        //Given
        let usersDataService = MockedUserService(mockedGetUserResponse: (nil, RequestError.badURL))
        viewModel = UsersViewModel(usersService: usersDataService)
        
        //When
        cancellable = viewModel.$users
            .dropFirst()
            .sink(receiveValue: { [weak self] value in
                self?.expectation.fulfill()
            })
        viewModel.getUsers()
        
        //Then
        wait(for: [expectation], timeout: 2)
        XCTAssertNotNil(viewModel.users.warning)
    }
    
}
