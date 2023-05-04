//
//  BaseURLConstants.swift
//  Demo002
//
//  Created by Julio Collado Perez on 5/1/23.
//

import Foundation

struct BaseURLConstants {
    
    private static let fileName  = "Info"
    private static let fileExtension  = ".plist"

    static var usersBaseURL: String {
        let globalKey = "USER_SERVER_API"
        guard let path = Bundle.main.path(forResource: fileName, ofType: fileExtension),
              let dictionary = NSDictionary(contentsOfFile: path),
              let baseUrl = dictionary[globalKey] as? String else {
            preconditionFailure("Could no load Info.plist")
        }

        return baseUrl
    }
    
}

