// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// Worked on by both

// User Home Page View

import SwiftUI
import Firebase

struct HomeView: View {
    
    //@EnvironmentObject private var homeViewModel : HomeViewModel
    @StateObject var homeViewModel = HomeViewModel.shared
    
    @EnvironmentObject var fireDBHelper : FireDBHelper


    @EnvironmentObject private var viewRouter: ViewRouter
    
    @State private var showPortfolio : Bool = true
    @State private var showUserPortflioSheet : Bool = false
    @State private var showSearchBar : Bool = false
    @State private var showMarketTab : Bool = true
    @State private var rippleAnimation : Bool = false
    @State private var showUserProfile : Bool = false // sheet for user profile settings
    
    //@State private var welcomeTextSwitch = true

    var body: some View {
        
            ZStack {
                
                // background stuff
                Color.theme.background
                    .ignoresSafeArea()
                
                // content stuff
                VStack{
                    
                    homeHeader
                    Divider().background(Color.theme.alien)
                    
                    if showSearchBar {
                        SearchBarView(searchText: $homeViewModel.searchText)
                        Divider().background(Color.theme.alien)
                    }
                    
                    if showMarketTab {
                        MarketTabFullView(showPortfolio: $showPortfolio)
                        Divider().background(Color.theme.alien)
                    }
                    
                    HStack{
                        Text("asset")
                        Spacer()
                        if showPortfolio{
                            Text("shares")
                        }
                        
                        Text("price")
                            .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing) //1/3 of the screen
                    }
                    .font(.body)
                    .foregroundColor(Color.theme.secondary)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    
                    Divider().background(Color.theme.alien)

                    
                    
                    if showPortfolio {
//                        List{
//                            ForEach(homeViewModel.allCoins){ crypto in
//                                CryptoRowView(crypto: crypto, showHoldingsColumn: true, urlString: crypto.image)
//                                   .listRowSeparator(.hidden)
//                            }
//                        }
//                        .listStyle(.plain)
//                        .transition(.move(edge:  .leading))
                        
                        List{
                            ForEach(self.fireDBHelper.assetList){currentAsset in

                                VStack(alignment: .leading){
                                    AssetAddedRowView(asset: currentAsset, showHoldingsColumn: true, urlString: currentAsset.imageString)
                                        .listRowSeparator(.hidden)
                                        
                                }

                            }//ForEach
                            .onDelete(perform: {indexSet in
                                for index in indexSet{
                                    print(#function, "Asset to delete : \(self.fireDBHelper.assetList[index].coinId)")

                                    self.fireDBHelper.removeAsset(assettoRemove: self.fireDBHelper.assetList[index])

                                }
                            })
                            
                            
                        }
                        .listStyle(.plain)
                        .transition(.move(edge:  .leading))
                        .onAppear(){
                            //get all books from DB
                            self.fireDBHelper.getAllAssets()
                        }
                    }
                    if !showPortfolio{
                        List{
                            ForEach(homeViewModel.allCoins){ crypto in
                                CryptoRowView(crypto: crypto, showHoldingsColumn: false, urlString: crypto.image)
                                   .listRowSeparator(.hidden)
                            }
                        }
                        .listStyle(.plain)
                        .transition(.move(edge:  .trailing))

                    }
                    
                     
                     Spacer(minLength: 0)
                }
                .sheet(isPresented: $showUserProfile){UserProfileView().environmentObject(homeViewModel)} //show user profile
                .sheet(isPresented: $showUserPortflioSheet){UserPortfolioView().environmentObject(homeViewModel)} // show the users portfolio
                
                VStack {
                    Spacer()
                    
//                    HStack {
//                        Spacer()
//                        SearchBarView(searchText: $homeViewModel.searchText)
//                    }
                }
        }
    }
}

extension HomeView {

    private var homeHeader: some View {
        VStack {
            
            
            // middle text
            welcomeText
                .padding(.top)
//                .onAppear{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // say welcome user then wait 2 seconds
//                        self.welcomeTextSwitch.toggle()
//                    }
//                }
            
            HStack(spacing: 25){
                
                // button on left side
                CircleButtonView(iconToUse: showPortfolio ? "person.fill" : "plus")
                    .animation(.none, value: showPortfolio)
                    .background(
                        RippleAnimation(animate: $rippleAnimation)
                    )
                    .onTapGesture {
                        if showPortfolio{
                            showUserProfile.toggle()
                        }
                        else {
                            showUserPortflioSheet.toggle()
                        }
                        
                    }
                
                
        

                
                CircleButtonView(iconToUse: "chart.line.uptrend.xyaxis")
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.3)){
                            showMarketTab.toggle()
                        }
                        
                    }
                    
                
                CircleButtonView(iconToUse: "magnifyingglass")
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.3)){
                            showSearchBar.toggle()
                        }
                    }
                   
                
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
    }
    
    
    private var welcomeText : some View {

        VStack{
            if !showPortfolio {
                Text("LIVE MARKET")
            }
            else {
                Text("PORTFOLIO")
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

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        HomeView()
//    }
//}
