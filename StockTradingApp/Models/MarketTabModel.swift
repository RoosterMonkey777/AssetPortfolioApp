//
//  MarketTabModel.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-12-04.
//

import Foundation

struct MarketTabModel : Identifiable {
    
    let id = UUID().uuidString
    let header: String
    let val: String
    let percChange: Double?
    
    init(header: String, val: String, percChange: Double? = nil) {
        self.header = header
        self.val = val
        self.percChange = percChange
    }
    
}
