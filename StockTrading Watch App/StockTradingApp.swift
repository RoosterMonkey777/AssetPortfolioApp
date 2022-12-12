// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

//worked on by Shareef

// main view of the watchos app

import SwiftUI

@main
struct StockTrading_Watch_AppApp: App {
    @StateObject var homeViewModel = HomeViewModel.shared

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(homeViewModel)
        }
    }
}

