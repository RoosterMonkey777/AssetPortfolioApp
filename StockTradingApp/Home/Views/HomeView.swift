// User Home Page View

import SwiftUI
import Firebase

struct HomeView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var showPortfolio : Bool = true
    @State private var rippleAnimation : Bool = false
    @State private var showUserProfile : Bool = false // sheet for user profile settings
    
    //@State private var welcomeTextSwitch = true

    var body: some View {
        NavigationView {
            ZStack {
                
                // background stuff
                Color.theme.background
                    .ignoresSafeArea()
                
                // content stuff
                VStack{
                    homeHeader
                     Spacer(minLength: 0)
                }
                .sheet(isPresented: $showUserProfile){UserProfileView()} //show user profile
            }
            .toolbar(.hidden)
        }
    }
}

extension HomeView {

    private var homeHeader: some View {
        HStack{
            
            // button on left side
            CircleButtonView(iconToUse: showPortfolio ? "person.fill" : "plus")
                .animation(.none, value: showPortfolio)
                .background(
                    RippleAnimation(animate: $rippleAnimation)
                )
                .onTapGesture {
                    showUserProfile.toggle()
                }
    
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
                        rippleAnimation.toggle()
                    }
                }
        }
        .padding(.horizontal)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
