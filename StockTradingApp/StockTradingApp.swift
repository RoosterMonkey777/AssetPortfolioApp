/* App main */

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth

// configure firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        // Auth.auth().useEmulator(withHost: "localhost", port: 9099) //firebase auth emulator suite
        return true
    }
}

@main
struct StockTradingApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // let assetHelper = AssetHelper()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                AuthenticatedView {
                    VStack{
                        Text("MY ASSET PORTFOLIO")
                            .font(.title)
                            .fontWeight(.heavy)
                            .padding(.vertical)
                            .shadow(radius: 50.0)
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color(.systemGreen))
                            .clipShape(Circle())
                            .clipped()
                            .overlay(
                                Circle().stroke(Color.green, lineWidth: 5)
                                    .shadow(radius: 50))
                    }
                    .padding()
                    Text("Track your favorite stocks, crypto and more!")
                        .fontWeight(.regular)
                        .shadow(radius: 50)
                        .padding()
                } content: {
                    HomePageView()
                    Spacer()
                }
            }
        }
    }
}


