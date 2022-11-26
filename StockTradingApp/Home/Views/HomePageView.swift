// Home Page -> First page the user will see when logged in

import SwiftUI

struct HomePageView: View {
    
    @State private var showPortfolio = true 
    @State private var welcomeTextSwitch = true
    @State private var rippleAnimation = false
    @State private var showUserProfile = false
    
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationStack{
            
            ZStack {
                
                // background stuff
                Color.theme.background
                    .ignoresSafeArea()
                
                // content stuff
                VStack{
                    homeHeader
                    
                   
                    Spacer(minLength: 0)
                    //TODO: Add more content
                }
                
                
            }
           
        }
    }
}

extension HomePageView {

    private var homeHeader: some View {
        HStack{
            
            // button on left side
            CircleButtonView(iconToUse: showPortfolio ? "person.fill" : "plus")
                .animation(.none, value: showPortfolio)
                .onTapGesture {
                    showPortfolio ? showUserProfile.toggle() : nil
                }
                .background(
                    RippleAnimation(animate: $rippleAnimation)
                )

            Spacer()
            
            // middle text
            welcomeText
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // say welcome user then wait 2 seconds
                        self.welcomeTextSwitch.toggle()
                    }
                }
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
        .sheet(isPresented: $showUserProfile) {
                UserProfileView()
                    .environmentObject(viewModel)
        }
    }
    
    
    private var welcomeText : some View {

        VStack{
            if !showPortfolio {
                Text("LIVE PRICES")
            }
            else {
                if !welcomeTextSwitch {
                    Text("PORTFOLIO")
                } else {
                    VStack(alignment: .center, spacing: 5){
                        Text("Welcome, ")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            
                        Text(viewModel.displayName)
                    }
                }
            }
        }
        .animation(.none, value: showPortfolio)
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(Color.theme.alien)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
