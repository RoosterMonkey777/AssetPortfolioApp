//
//  HomeView.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-11-26.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var showPortfolio = true
    //@State private var welcomeTextSwitch = true
    //@State private var rippleAnimation = false
    //@State private var showUserProfile = false
    //@State private var presentingProfileScreen = false
    
    @State var signOutProcessing = false
    @State var deleteProcessing = false
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                // background stuff
                Color.theme.background
                    .ignoresSafeArea()
                
                // content stuff
                VStack{
                    homeHeader
                    Text("HomeView")
                        .navigationTitle("V24")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                if signOutProcessing {
                                    ProgressView()
                                } else {
                                    Button("Sign Out") {
                                        signOutUser()
                                    }
                                }
                            }
                            ToolbarItem(placement: .navigationBarLeading) {
                                if signOutProcessing {
                                    ProgressView()
                                } else {
                                    Button("Delete") {
                                        deleteUser()
                                    }
                                }
                            }
                        }
                    
                   
                    // Spacer(minLength: 0)
                    //TODO: Add more content
                }
                
                
            }
            
            
            
            
        }
    }
    
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {

    private var homeHeader: some View {
        HStack{
            
            // button on left side
            CircleButtonView(iconToUse: showPortfolio ? "person.fill" : "plus")
                .animation(.none, value: showPortfolio)
//                .background(
//                    RippleAnimation(animate: $rippleAnimation)
//                )
            
//            Button("Tap here to view your profile") {
//              presentingProfileScreen.toggle()
//          }
            

            Spacer()
            
            // middle text
            welcomeText
//                .onAppear{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // say welcome user then wait 2 seconds
//                        self.welcomeTextSwitch.toggle()
//                    }
//                }
            Spacer()
            
            // button on right side
            CircleButtonView(iconToUse: "arrow.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 0 : -180))
                .onTapGesture {
                    //showPortfolio.toggle()
                    withAnimation(.spring()){ // gives it that smooth transition
                        showPortfolio.toggle()
//                        rippleAnimation.toggle()
                    }
                }
        }
//        .sheet(isPresented: $presentingProfileScreen) {
//          NavigationView {
//            UserProfileView()
//              .environmentObject(viewModel)
//          }
//        }
       
    }
    
    
    private var welcomeText : some View {

        VStack{
            if !showPortfolio {
                Text("LIVE PRICES")
            }
            else {
                Text("Portfolio")
//                if !welcomeTextSwitch {
//                    Text("PORTFOLIO")
//                } else {
//                    VStack(alignment: .center, spacing: 5){
//                        Text("Welcome, ")
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//
//                        Text(viewModel.displayName)
//                    }
//                }
            }
        }
        .animation(.none, value: showPortfolio)
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(Color.theme.alien)
    }
}
