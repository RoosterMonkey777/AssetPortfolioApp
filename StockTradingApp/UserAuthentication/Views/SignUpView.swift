// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// worked on by zahaak

//  View for letting users sign into their acccount through firebase authentication

import SwiftUI
import Firebase

private enum FocusableField: Hashable {
  case email
  case password
  case passwordConfirmation
}

struct SignUpView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    
    @State var signUpProcessing = false
    @State var signUpErrorMessage = ""
    
    var body: some View {
        VStack{
            Spacer()
            LogoView()
            Text("Sign Up")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .foregroundColor(Color.theme.primary)
           
            SignUpCredentialFields(email: $email, password: $password, passwordConfirmation: $passwordConfirmation)
            
            Button(action: {
                signUpUser(userEmail: email, userPassword: password)
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .bold()
                    .background(Color.theme.buttoncolor1)
                    .cornerRadius(15)
            }
            .disabled(!signUpProcessing && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty && password == passwordConfirmation ? false : true)
            
            if !signUpErrorMessage.isEmpty {
                Text("Failed creating account: \(signUpErrorMessage)")
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text("Already have an account?")
                Button(action: {
                    viewRouter.currentPage = .signInPage
                }) {
                    Text("Login")
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
    
    // sign up the user account using firebase authenticaiton
    func signUpUser(userEmail: String, userPassword: String) {
        
        signUpProcessing = true
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                signUpErrorMessage = error!.localizedDescription
                signUpProcessing = false
                return
            }
            
            switch authResult {
            case .none:
                print("Could not create account.")
                signUpProcessing = false
            case .some(_):
                print("User created")
                
                if( authResult != nil){
                    //FIRUser
                    print(#function, "User Info : \(authResult!.user.email ?? "NA")")
                    print(#function, "User displayName : \(authResult!.user.displayName ?? "NA")")
                    
                    UserDefaults.standard.set(authResult!.user.email, forKey: "KEY_EMAIL")
                }
                
                signUpProcessing = false
                viewRouter.currentPage = .homePage
            }
        }
    }
}

// view consisting of the app title and the app logo
struct LogoView: View {
    var body: some View {
        
        VStack(spacing: 40){
            VStack(spacing: 5){
                Text("MY ASSET TRACKER")
                    .foregroundColor(Color.theme.primary)
                    .font(.title)
                    .fontWeight(.heavy)
                
                Text("Track your favorite stocks, crypto and more!")
                    .foregroundColor(Color.theme.secondary)
                    .fontWeight(.light)
                    .font(.subheadline)
                    .padding()
            }
            
            Image(systemName: "chart.line.uptrend.xyaxis")
                .resizable()
                .frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.theme.bull)
                .clipShape(Circle())
                .clipped()
                .overlay(
                    Circle().stroke(Color.theme.bull, lineWidth: 5)
                )
        }
    }
}

// view that lets user input their sign up information
struct SignUpCredentialFields: View {
    @FocusState private var focus: FocusableField?
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirmation: String
    
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
            .submitLabel(.next)
            .onSubmit {
                self.focus = .passwordConfirmation
            }
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 8)

        HStack {
          Image(systemName: "lock")
          SecureField("Confirm password", text: $passwordConfirmation)
            .focused($focus, equals: .passwordConfirmation)
        }
        .padding(.vertical, 6)
        .background(Divider(), alignment: .bottom)
        .padding(.bottom, 8)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

