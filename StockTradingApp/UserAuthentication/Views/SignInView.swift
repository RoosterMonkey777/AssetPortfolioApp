// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// worked on by Zahaak

//  View for letting users sign into their acccount through firebase authentication

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
            LogoView() // consits of app title, and app logo
            
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
                Text("Login ")
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .bold()
                    .background(Color.theme.buttoncolor1)
                    .cornerRadius(15)
            }
            .disabled(!signInProcessing && !email.isEmpty && !password.isEmpty ? false : true) // if fields empty dont show

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
    
    // Sign in user into their firebase authenticated account if it exists
    private func signInUser(userEmail: String, userPassword: String) {
        
        signInProcessing = true
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                signInProcessing = false
                signInErrorMessage = error!.localizedDescription
                return
            }
            switch authResult {
            case .none:
                print("Error: the User could not be signed in.")
                signInProcessing = false
            case .some(_):
                print("Success: the User signed in")
                
                if( authResult != nil){
                    //FIRUser
                    print(#function, "User Info : \(authResult!.user.email ?? "NA")")
                    print(#function, "User displayName : \(authResult!.user.displayName ?? "NA")")
                    
                    UserDefaults.standard.set(authResult!.user.email, forKey: "KEY_EMAIL")
                }
                signInProcessing = false
                withAnimation {
                    viewRouter.currentPage = .homePage
                }
            }
        }
    }
}

// view that takes in the users inputs and creates the account
struct SignInCredentialFields: View {
    @FocusState private var focus: FocusableField?

    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

