//
//  Asset.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-11-23.
//

import Foundation
import UIKit

struct Meta :  Codable {
    
    let symbol : String
    let interval : String
    let exchange : String
    let type : String
}

struct Asset : Codable{
    
    let symbol: String
    let interval: String
    let exchange : String
    let type : String
    let status : String
    //let values : [String] // this is an array of values that I need to get depending on the
    
    enum AssetKeys : String, CodingKey{
        
        case meta
        case status = "status"
        
        enum MetaKeys : String, CodingKey {
            
            case symbol = "symbol"
            case interval = "interval"
            case exchange = "exchange"
            case type = "type"
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: AssetKeys.self)
        let metacontainer = try container.decodeIfPresent(Meta.self, forKey: .meta)
        
        self.symbol = metacontainer?.symbol ?? "NA"
        self.interval = metacontainer?.interval ?? "NA"
        self.exchange = metacontainer?.exchange ?? "NA"
        self.type = metacontainer?.type ?? "NA"
        self.status = try container.decodeIfPresent(String.self, forKey: .status) ?? "NA"
        
    }
}

