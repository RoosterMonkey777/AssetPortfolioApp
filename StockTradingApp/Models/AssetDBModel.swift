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
    var amount : Double = 0
    // var dateAdded : Date = Date()

    init(coinId: String, amount: Double){
        self.coinId = coinId
        self.amount = amount
    }

    init(){}
    
    //Failable initializer
    init?(dictionary: [String: Any]){

        guard let coinId = dictionary["coinId"] as? String else{
            return nil
        }

        guard let amount = dictionary["amount"] as? String else{
            return nil
        }


        self.init(coinId: coinId, amount: (Double(amount) ?? 0))

    }
}
