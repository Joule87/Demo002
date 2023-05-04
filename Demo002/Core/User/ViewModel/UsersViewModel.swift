//
//  UsersViewModel.swift
//  Demo002
//
//  Created by Julio Collado Perez on 4/30/23.
//

import Combine
import Foundation

protocol UsersViewModelInterface {
    var isProcessingRequest: Bool { get }
    var users: (list: [User]?, warning: String?) { get }
    init(usersService: UserServiceInterface)
    
    func getUsers()
}

final class UsersViewModel: UsersViewModelInterface, ObservableObject {
    
    private let usersService: UserServiceInterface
    
    @Published private(set) var isProcessingRequest: Bool = false
    @Published private(set) var users: (list: [User]?, warning: String?)
    @Published private(set) var errorDescription: String?
    
    private var subscribers = Set<AnyCancellable>()
    
    init(usersService: UserServiceInterface) {
        self.usersService = usersService
        addSubscriber()
    }
    
    func getUsers() {
        isProcessingRequest = true
        usersService.requestUsers()
    }
    
    private func addSubscriber() {
        usersService.usersPublisher
            .receive(on: DispatchQueue.main)
            .map { rawUserList in
                return rawUserList.map({ User(id: String($0.id), firstName: $0.firstName, lastName: $0.lastName) })
            }
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.users = (nil, error.localizedDescription)
                    self?.isProcessingRequest = false
                }
            } receiveValue: { [weak self] users in
                self?.users = (users, nil)
                self?.isProcessingRequest = false
            }
            .store(in: &subscribers)
    }
}

