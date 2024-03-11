//
//  User.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 7/3/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

struct AppUser: Codable {
    let id: String
    let fullname: String
    let email: String

    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return " "
    }
}
  /*  func encodeUser(){
        do {
            let user1 = AppUser(id: id, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user1)
            print("DEBUG: Encoded user successfully - \(encodedUser)")
        } catch {
            print("DEBUG: Failed to encode user with error \(error.localizedDescription)")
        }
    }
*/
    extension AppUser {
        static var MOCK_USER = AppUser(id: NSUUID().uuidString, fullname: "Kobe Bryant", email: "test@gmail.com")
    }



