//
//  CryptoModelView.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-11-28.
//

import SwiftUI

struct CryptoRowView: View {
    
    let crypto : CryptoModel
    let showHoldingsColumn : Bool
    
    var body: some View {
        
        HStack(spacing: 0){
            
            // left column
            Text("\(crypto.getRank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondary)
                .frame(minWidth: 30)
            
            Circle()
                .frame(width: 30, height: 30)
            
            Text(crypto.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.primary)
            
            Spacer()
            
            // middle column if applicable
            if showHoldingsColumn {
                VStack(alignment: .trailing){
                    Text(crypto.currentCoinHoldingsValue.formatAssetPriceToTwo())
                        .bold()
                    Text((crypto.coinHoldings ?? 0).formatAssetPriceToSix())
                }
                .foregroundColor(Color.theme.primary)
            }
            
            // riight column
            VStack(alignment: .trailing){
                Text("\(crypto.currentPrice.formatAssetPriceToSix())")
                    .bold()
                    .foregroundColor(Color.theme.primary)
                Text("\(crypto.priceChangePercentage24H?.formatToPercentString() ?? "") %")
                    .foregroundColor(
                        (crypto.priceChangePercentage24H ?? 0) <= 0 ?
                        Color.theme.bear :
                        Color.theme.bull
                    )
            }.frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing) //1/3 of the screen
        }
        .font(.subheadline)
    }
}

struct CryptoRowView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoRowView(crypto: shared_dev.crypto, showHoldingsColumn: true)
    }
}


