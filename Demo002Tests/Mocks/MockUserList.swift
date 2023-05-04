//
//  MockUserList.swift
//  Demo002Tests
//
//  Created by Julio Collado Perez on 5/2/23.
//

import Foundation
import Combine
@testable import Demo002

struct MockUsers {
    static let userList: [UserDTO] = [
        UserDTO(id: 1, firstName: "John", lastName: "Doe", userName: "johndoe", email: "johndoe@example.com", gender: "male", imageStringURL: "https://randomuser.me/api/portraits/men/1.jpg", phone: "(123) 456-7890", birthday: "1980-01-01", twitterHandle: "@johndoe"),
        UserDTO(id: 2, firstName: "Jane", lastName: "Smith", userName: "janesmith", email: "janesmith@example.com", gender: "female", imageStringURL: "https://randomuser.me/api/portraits/women/2.jpg", phone: "(123) 456-7890", birthday: "1985-01-01", twitterHandle: "@janesmith"),
        UserDTO(id: 3, firstName: "Bob", lastName: "Johnson", userName: "bobjohnson", email: "bobjohnson@example.com", gender: "male", imageStringURL: "https://randomuser.me/api/portraits/men/3.jpg", phone: "(123) 456-7890", birthday: "1990-01-01", twitterHandle: "@bobjohnson")
    ]
    
    static let userListJSON: String = """
           [
               {
                   "id": 1,
                   "firstName": "John",
                   "lastName": "Doe",
                   "username": "johndoe",
                   "email": "johndoe@example.com",
                   "gender": "male",
                   "pictureURL": "https://randomuser.me/api/portraits/men/1.jpg",
                   "phone": "(123) 456-7890",
                   "birthday": "1980-01-01",
                   "twitterHandle": "@johndoe"
               },
               {
                   "id": 2,
                   "firstName": "Jane",
                   "lastName": "Smith",
                   "username": "janesmith",
                   "email": "janesmith@example.com",
                   "gender": "female",
                   "pictureURL": "https://randomuser.me/api/portraits/women/2.jpg",
                   "phone": "(123) 456-7890",
                   "birthday": "1985-01-01",
                   "twitterHandle": "@janesmith"
               },
               {
                   "id": 3,
                   "firstName": "Bob",
                   "lastName": "Johnson",
                   "username": "bobjohnson",
                   "email": "bobjohnson@example.com",
                   "gender": "male",
                   "pictureURL": "https://randomuser.me/api/portraits/men/3.jpg",
                   "phone": "(123) 456-7890",
                   "birthday": "1990-01-01",
                   "twitterHandle": "@bobjohnson"
               }
           ]

           """
}
