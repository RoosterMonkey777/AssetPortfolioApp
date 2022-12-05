//
//  MarketTabView.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-12-04.
//

import SwiftUI

struct MarketTabView: View {
    
    let holder: MarketTabModel
    var body: some View {
        VStack(spacing: 10){
            Text(holder.header)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.secondary)
            Text(holder.val)
                .foregroundColor(Color.theme.alien)
                .fontWeight(.heavy)
                .font(.title2)
            
            HStack(alignment: .top){

                Text(holder.percChange?.asPercentString() ?? "")
                    .fontWeight(.bold)
                
                Image(systemName: "arrow.up")
                    .fontWeight(.semibold)
                    .rotationEffect(Angle(degrees: (holder.percChange ?? 0 ) >= 0 ? 0 : 180))
            }
            .foregroundColor((holder.percChange ?? 0 ) >= 0 ? Color.theme.bull : Color.theme.bear)
            .opacity(holder.percChange == nil ? 0 : 1)
        }
    }
}

struct MarketTabView_Previews: PreviewProvider {
    static var previews: some View {
        MarketTabView(holder: shared_dev.holder2)
    }
}
