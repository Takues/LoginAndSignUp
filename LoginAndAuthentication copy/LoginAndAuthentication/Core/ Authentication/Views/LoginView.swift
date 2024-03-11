//
//  LoginView.swift
//  LoginAndAuthentication
//
//  Created by Takudzwa Zindoga on 5/3/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginSuccessful: Bool = false
    @State private var showingAlert = true
    @State private var isNavigationActive = false
    @StateObject var viewModel = AuthenticationViewModel()
   

    //Have to change it to a Environment Object so it can be used across multiple views within the Application.
    //@EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        NavigationStack {
            VStack {
                // Image
                Image("Matter-logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)

                // fore fields
                VStack(spacing: 24) {
                    InputView(text:$email, title: "Email Address", placeholder: "name@example.com")
                        .autocapitalization(.none)


                    InputView(text: $password, title: "Password", placeholder: "Enter Your Password", isSecureField: true )

                }
                .padding(.horizontal)
                .padding(.top, 20)

                //Sign in button
                Button {
                    Task{
                        if email.isEmpty && password.isEmpty {
                            showingAlert = true
                            return
                        }
                        do {
                            try await viewModel.signIn(withEmail: email, password: password)
                            isLoginSuccessful = true
                            viewModel.isAuthenticated = true

                            isNavigationActive = true
                            // navigateToHomePage()
                            //  navigateToHomePage()
                        } catch let error as NSError {
                            print("Authentication Error: \(error.localizedDescription), Code: \(error.code)")
                            showingAlert = true
                        }
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow-right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 40)

                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                .fullScreenCover(isPresented: $isLoginSuccessful, content: {
                    HomePageView()
                        .ignoresSafeArea()
                })
               /* Button("Forgot Password?") {
                    sendPasswordResetEmail()
                }
                .foregroundColor(.blue)
                .padding(.top, 16)
*/

                

              /*  private func navigateToHomePage() {
                   viewModel.isAuthenticated = true
               }
*/
                Spacer()
                //Sign up button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text(" Don't Have an account ?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 16))
                }
            }
            .navigationTitle(" ")

        }
    }
}

/*private func sendPasswordResetEmail() {
    Auth.auth().sendPasswordReset(withEmail: email) { error in
        if let error = error {
            print("Error sending password reset email: \(error.localizedDescription)")
        } else {
            print("Password reset email sent successfully")
        }
    }*/
    /*private func navigateToHomePage() {

     viewModel.isAuthenticated = true
     isNavigationActive = true
     }*/


    // Mark: - AuthenticationFormProtocol
    extension LoginView: AuthenticationFormProtocol {
        var formIsValid: Bool {
            return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && password.count > 5

        }
    }

    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
    /*#Preview {
     LoginView()
     }
     */


