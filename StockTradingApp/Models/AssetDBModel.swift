//
//  AssetDBModel.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-12-11.
//

import Foundation
import FirebaseFirestoreSwift

struct AssetDBModel : Codable, Identifiable{
    @DocumentID var id : String? = UUID().uuidString
    var coinId : String = ""
    var name : String = ""
    var rank : Int = 0
    var symbol : String = ""
    var currentPrice : Double = 0
    var dailyChagePercentage : Double = 0
    var imageString : String = ""
    var amount : Double = 0
   
    // var dateAdded : Date = Date()

    init(coinId: String, name: String, rank: Int, symbol: String, currentPrice: Double, dailyChangePercentage: Double, imageString : String, amount: Double){
        self.coinId = coinId // coin name
        self.name = name
        self.rank = rank
        self.symbol = symbol
        self.currentPrice = currentPrice
        self.dailyChagePercentage = dailyChangePercentage
        self.imageString = imageString
        self.amount = amount
    }

    init(){}
    
    //Failable initializer
    init?(dictionary: [String: Any]){

        guard let coinId = dictionary["coinId"] as? String else{
            return nil
        }
        guard let name = dictionary["name"] as? String else{
            return nil
        }
        guard let rank = dictionary["rank"] as? Int else{
            return nil
        }
        guard let symbol = dictionary["symbol"] as? String else{
            return nil
        }
        guard let currentPrice = dictionary["currentPrice"] as? Double else{
            return nil
        }
        guard let dailyChagePercentage = dictionary["dailyChagePercentage"] as? Double else{
            return nil
        }
        guard let imageString = dictionary["imageString"] as? String else{
            return nil
        }
        guard let amount = dictionary["amount"] as? Double else{
            return nil
        }


        self.init(coinId: coinId, name: name, rank: rank, symbol: symbol, currentPrice: currentPrice, dailyChangePercentage: dailyChagePercentage, imageString: imageString, amount: Double(amount))

    }
    
    var getRank : Int {
        return Int(rank)
    }

    var currentCoinHoldingsValue : Double {
        return currentPrice  * (amount)
    }
}
