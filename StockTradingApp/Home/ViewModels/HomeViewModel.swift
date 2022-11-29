//
//  HomeViewModel.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-11-28.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCryptocurrencies : [CryptoModel] = []
    @Published var portfolioCryptoCurrencies : [CryptoModel] = []
    
    init() {
        
    }
    
    
}
