//
//  UsersView.swift
//  Demo002
//
//  Created by Julio Collado Perez on 4/30/23.
//

import SwiftUI

struct UsersView: View {
    
    @StateObject private var viewModel = UsersViewModel(usersService: UserService())
    
    func alertView(value: String, icon: String) -> some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 20, height: 20)
            Text("\(value)")
        }
    }
    
    var body: some View {
        ZStack {
            if viewModel.isProcessingRequest {
                ProgressView()
            } else {
                userListView
            }
        }
        .onAppear {
            viewModel.getUsers()
        }
    }
    
    var userListView: some View {
        ZStack {
            if let warning = viewModel.users.warning {
                alertView(value: warning, icon: "x.circle")
            }
            else if viewModel.users.list?.isEmpty ?? true {
                alertView(value: "no users found", icon: "text.magnifyingglass")
            } else if let users = viewModel.users.list {
                List(users) { user in
                    Text("\(user.firstName) \(user.lastName)")
                }
            }
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
