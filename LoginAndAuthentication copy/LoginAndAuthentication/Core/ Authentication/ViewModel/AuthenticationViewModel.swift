//
//  AuthenticationViewModal.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 7/3/2024.
//

import Foundation
import Firebase
import FirebaseAuth

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthenticationViewModel: ObservableObject {
    @Published var userSession: Firebase.User?
    @Published var currentUser: AppUser?
    @Published var isAuthenticated = false




    init() {
        self.userSession = Auth.auth().currentUser


        Task {
            await fetchUser()
        }
    }

    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            isAuthenticated = true
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            throw error
        }

    }

    //Asynchronous function that can potentially throw an error if anything goes wrong
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            //Create a user using Firebase Authentication
            let results = try await Auth.auth().createUser(withEmail: email, password: password)

            // Set the userSession property with the authenticated user
            self.userSession = results.user

            // Creates an AppUser instance with the user's informatin
            let user =  AppUser(id: results.user.uid, fullname:  fullname, email: email)

            // Encode the AppUser object using Firestore.Encoder
           let encodedUser = try Firestore.Encoder().encode(user)

            // Uploads the encoded user information to Firestore
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)

            // Fetches the user data from Firestore to update the app state
            await fetchUser()
        } catch {

            //Handles any errors that occur during the process
            print("DEBUG: Failed to create user with: \(error.localizedDescription)")
            throw error
        }

    }

    func signOut() {
        do {
            try Auth.auth().signOut()// sign out usser on backend
            self.userSession = nil // wipes outb user and takes them to login screen
            self.currentUser = nil // wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }

    func deleteAccount() async {
        do {
                // Check if the user is already signed out
                guard let user = Auth.auth().currentUser else {
                    print("DEBUG: User is already signed out")
                    return
                }

                // Delete the user account
                try await user.delete()

                // Handle successful account deletion
                self.userSession = nil
                self.currentUser = nil
                print("DEBUG: Account deleted successfully")
            } catch {
                print("DEBUG: Failed to delete account with error \(error.localizedDescription)")
            }
    }

    func fetchUser() async {
        if let uid = Auth.auth().currentUser?.uid {
            do {
                let snapshot = try await Firestore.firestore().collection("user").document(uid).getDocument()
                if snapshot.exists {
                    self.currentUser = try snapshot.data(as: AppUser.self)
                    print("DEBUG: Current user is \(String(describing: self.currentUser))")
                } else {
                    print("DEBUG: User document does not exist")
                }
            } catch {
                print("DEBUG: Failed to fetch user with error \(error.localizedDescription)")
            }
        } else {
            print("DEBUG: Current user UID is nil")
        }
    }

}

