//
//  MarketTabFullView.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-12-04.
//

import SwiftUI

struct MarketTabFullView: View {
    
    @Binding var showPortfolio: Bool
   
    @EnvironmentObject private var homeViewModel : HomeViewModel
    
    var body: some View {
        
        HStack{
            ForEach(homeViewModel.markets) { market in
                MarketTabView(holder: market)
                    .frame(width: UIScreen.main.bounds.width / 3)
                
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .leading : .trailing)
    }
}

struct MarketTabFullView_Previews: PreviewProvider {
    static var previews: some View {
        MarketTabFullView(showPortfolio: .constant(false))
            .environmentObject(shared_dev.homeVM)
    }
}
