//
//  UserProfileView.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-11-20.
//

import SwiftUI
import FirebaseAuth

struct UserProfileView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter

    @Environment(\.dismiss) var dismiss
    @State var signOutProcessing = false
    @State var deleteProcessing = false
    @State var presentingConfirmationDialog = false
    
    private func signOutUser() {
        signOutProcessing = true
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            signOutProcessing = false
        }
        withAnimation {
            viewRouter.currentPage = .signInPage
        }
    }
    private func deleteUser(){
        deleteProcessing = true
        let user = Auth.auth().currentUser
        
        user?.delete { error in
          if let error = error {
              print("Error deleting account: %@", error)
          } else {
            print("Account deleted")
          }
            deleteProcessing = false
        }
        withAnimation {
            viewRouter.currentPage = .signInPage
        }
    }
    
    var body: some View {
        Form {
                    Section {
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 100 , height: 100)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .clipped()
                                    .padding(4)
                                    .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
                                Spacer()
                            }
                            Button(action: {}) {
                                Text("edit")
                            }
                        }
                    }
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                    Section("Email") {
                        Text("email goes here")
                    }
                    Section {
                        Button(role: .cancel, action: signOutUser) {
                            HStack {
                                Spacer()
                                Text("Sign out")
                                Spacer()
                            }
                        }
                    }
                    Section {
                        Button(role: .destructive, action: { presentingConfirmationDialog.toggle() }) {
                            HStack {
                                Spacer()
                                Text("Delete Account")
                                Spacer()
                            }
                        }
                    }
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .confirmationDialog("Deleting your account is permanent. Do you want to delete your account?",
                                    isPresented: $presentingConfirmationDialog, titleVisibility: .visible) {
                    Button("Delete Account", role: .destructive, action: deleteUser)
                    Button("Cancel", role: .cancel, action: { })
                }
    }
}
//struct UserProfileView: View {
//
//    @EnvironmentObject var viewModel: AuthenticationViewModel
//    @Environment(\.dismiss) var dismiss
//    @State var presentingConfirmationDialog = false
//
//    private func deleteAccount() {
//        Task {
//            if await viewModel.deleteAccount() == true {
//                dismiss()
//            }
//        }
//    }
//
//    private func signOut() {
//        viewModel.signOut()
//    }
//
//    var body: some View {
//        Form {
//            Section {
//                VStack {
//                    HStack {
//                        Spacer()
//                        Image(systemName: "person.fill")
//                            .resizable()
//                            .frame(width: 100 , height: 100)
//                            .aspectRatio(contentMode: .fit)
//                            .clipShape(Circle())
//                            .clipped()
//                            .padding(4)
//                            .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
//                        Spacer()
//                    }
//                    Button(action: {}) {
//                        Text("edit")
//                    }
//                }
//            }
//            .listRowBackground(Color(UIColor.systemGroupedBackground))
//            Section("Email") {
//                Text(viewModel.displayName)
//            }
//            Section {
//                Button(role: .cancel, action: signOut) {
//                    HStack {
//                        Spacer()
//                        Text("Sign out")
//                        Spacer()
//                    }
//                }
//            }
//            Section {
//                Button(role: .destructive, action: { presentingConfirmationDialog.toggle() }) {
//                    HStack {
//                        Spacer()
//                        Text("Delete Account")
//                        Spacer()
//                    }
//                }
//            }
//        }
//        .navigationTitle("Profile")
//        .navigationBarTitleDisplayMode(.inline)
//        .confirmationDialog("Deleting your account is permanent. Do you want to delete your account?",
//                            isPresented: $presentingConfirmationDialog, titleVisibility: .visible) {
//            Button("Delete Account", role: .destructive, action: deleteAccount)
//            Button("Cancel", role: .cancel, action: { })
//        }
//    }
//}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserProfileView()
                .environmentObject(AuthenticationViewModel())
        }
    }
}
