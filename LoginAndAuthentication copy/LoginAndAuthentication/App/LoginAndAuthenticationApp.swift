//
//  LoginAndAuthenticationApp.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 5/3/2024.
//

import SwiftUI
import Firebase
import FirebaseCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct LoginAndAuthenticationApp: App {
    @StateObject var viewModel = AuthenticationViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
