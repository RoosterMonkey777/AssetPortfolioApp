//
//  SignInView.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-11-26.
//

import SwiftUI
import Firebase

private enum FocusableField: Hashable {
  case email
  case password
}

struct SignInView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter

    
    @State var email = ""
    @State var password = ""
    
    @State var signInProcessing = false
    @State var signInErrorMessage = ""
    
    var body: some View {
        
        VStack {
            
            Spacer()
            LogoView()
            
            // page header
            Text("Login")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .foregroundColor(Color.theme.primary)
            
            SignInCredentialFields(email: $email, password: $password)
            Button(action: {
                signInUser(userEmail: email, userPassword: password)
            }) {
                Text("Sign In")
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .bold()
                    .background(Color.theme.buttoncolor1)
                    .cornerRadius(15)
            }
            .disabled(!signInProcessing && !email.isEmpty && !password.isEmpty ? false : true)
            
            

            if !signInErrorMessage.isEmpty {
                Text("Failed creating account: \(signInErrorMessage)")
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text("Don't have an account?")
                Button(action: {
                    viewRouter.currentPage = .signUpPage
                }) {
                    Text("Sign Up")
                        .foregroundColor(Color.theme.buttoncolor1)
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            .opacity(0.9)
            .padding(.bottom).padding(.bottom)
        }
        .padding()
        
    }
    
    func signInUser(userEmail: String, userPassword: String) {
        
        signInProcessing = true
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                signInProcessing = false
                signInErrorMessage = error!.localizedDescription
                return
            }
            switch authResult {
            case .none:
                print("Could not sign in user.")
                signInProcessing = false
            case .some(_):
                print("User signed in")
                signInProcessing = false
                withAnimation {
                    viewRouter.currentPage = .homePage
                }
            }
            
        }

    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}


struct SignInCredentialFields: View {
    @FocusState private var focus: FocusableField?

    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
//        Group {
//            TextField("Email", text: $email)
//                .padding()
//                .background(.thinMaterial)
//                .cornerRadius(10)
//                .textInputAutocapitalization(.never)
//            SecureField("Password", text: $password)
//                .padding()
//                .background(.thinMaterial)
//                .cornerRadius(10)
//                .padding(.bottom, 30)
//        }
        
        HStack {
          Image(systemName: "at")
          TextField("Email", text: $email)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .focused($focus, equals: .email)
            .submitLabel(.next)
            .onSubmit {
              self.focus = .password
            }
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 4)

        HStack {
          Image(systemName: "lock")
          SecureField("Password", text: $password)
            .focused($focus, equals: .password)
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 8)
    }
}
