//
//  ContentView.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 5/3/2024.
//

import SwiftUI
import CoreData


struct HomeView: View {
    var body: some View {
        TabView {
            DevicesContentView()
        }
    }
}
struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        Group{
            if viewModel.userSession != nil {
                NavigationView {
                    LoginView()
                }
            } else {
                ProfileView()
            }


        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthenticationViewModel())
    }
}
