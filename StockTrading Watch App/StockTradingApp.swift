//
//  StockTradingApp.swift
//  StockTrading Watch App
//
//  Created by user226655 on 12/11/22.
//

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

