//
//  ContentView.swift
//  StockTrading Watch App
//
//  Created by user226655 on 12/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var homeViewModel = HomeViewModel.shared
    var body: some View {
        VStack {
            List{
                ForEach(homeViewModel.allWatchCryptocurrencies){ crypto in
                    VStack(alignment: .leading, spacing: 2){
                        HStack (alignment: .top){
                            Text("\(crypto.getRank)")
                                .foregroundColor(Color.secondary)
                                .frame(minWidth: 5)
                                .font(.system(size: 10))
                                
                            Text(crypto.symbol.uppercased())
                                .padding(.leading, 1)
                                .foregroundColor(Color.primary)
                                .font(.system(size: 10))
                        }
                        //Horizontal Stack for Icon and the current price
                        HStack(alignment: .lastTextBaseline) {
                            AssetImageView(urlString: crypto.image, data: nil)
                            Spacer()
                            Text("\(String(format: "%.2f", crypto.current_price))")
                                                    
                        }
                        //Horizontal Stack for name and the price change
                        HStack(alignment: .lastTextBaseline) {
                            Text(crypto.name.uppercased())
                                .font(.system(size: 11))
                                .foregroundColor(Color.primary)
                             Spacer()
                            Text("\(String(format: "%.2f", crypto.price_change_percentage_24h!))%")
                        }
                        
                        
                    }
                        
                }
                
                .listStyle(.plain)
                .transition(.move(edge:  .leading))
            }
            .padding()
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }}
