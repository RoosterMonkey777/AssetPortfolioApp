/* App main */

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore


@main
struct StockTradingApp: App {

    
    @StateObject var homeViewModel = HomeViewModel.shared
    @StateObject var viewRouter = ViewRouter()
   
    init() { FirebaseApp.configure() }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                MainView()
                    .environmentObject(viewRouter)
                    .environmentObject(homeViewModel)
            }
            .toolbar(.hidden)
        }
    }
}


