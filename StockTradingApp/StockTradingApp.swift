/*
    App main
 */

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

    var body: some Scene {
        WindowGroup {
            NavigationView {
                // ContentView()
                AuthenticatedView {
                    Image(systemName: "number.circle.fill")
                        .resizable()
                        .frame(width: 100 , height: 100)
                        .foregroundColor(Color(.systemPink))
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .clipped()
                        .padding(4)
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    Text("Welcome to My Portfolio")
                        .font(.title)
                    Text("Please log in to use the app!")
                } content: {
                    HomePageView()
                    Spacer()
                }
            }
        }
    }
}


