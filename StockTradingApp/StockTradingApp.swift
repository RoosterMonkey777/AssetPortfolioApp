/* App main */

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth

//// configure firebase
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        // Auth.auth().useEmulator(withHost: "localhost", port: 9099) //firebase auth emulator suite
//        return true
//    }
//}
//
//@main
//struct StockTradingApp: App {
//
//    // register app delegate for Firebase setup
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//    var body: some Scene {
//        WindowGroup {
//            NavigationView {
//
//                AuthenticatedView {
//                    VStack{
//
//                        // App title
//                        Text("MY ASSET PORTFOLIO")
//                            .font(.title)
//                            .fontWeight(.heavy)
//                            .foregroundColor(Color.theme.primary)
//                            .padding(.vertical)
//
//                        // Main App Logo
//                        Image(systemName: "chart.line.uptrend.xyaxis")
//                            .resizable()
//                            .frame(width: 150, height: 150)
//                            .aspectRatio(contentMode: .fit)
//                            .foregroundColor(Color.theme.bull)
//                            .clipShape(Circle())
//                            .clipped()
//                            .overlay(
//                                Circle().stroke(Color.theme.bull, lineWidth: 5)
//                                    .shadow(
//                                        color: Color.theme.bull.opacity(0.5),
//                                        radius: 15, x:0, y:0)
//                            )
//
//                        // App main phrase
//                        Text("Track your favorite stocks, crypto and more!")
//                            .foregroundColor(Color.theme.primary)
//                            .fontWeight(.light)
//                            .font(.subheadline)
//                            .padding()
//                    }
//                    .padding()
//
//                } content: {
//                    HomePageView()
//                }
//                .toolbar(.hidden)
//            }
//
//        }
//    }
//}

@main
struct StockTradingApp: App {

    @StateObject var viewRouter = ViewRouter()
   
    init() {
            FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewRouter)
        }
    }
}


