//
//  AssetDBModel.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-12-11.
//

import Foundation
import FirebaseFirestoreSwift

struct AssetDBModel : Codable, Hashable{
    @DocumentID var id : String? = UUID().uuidString
    var coinId : String = ""
    var amount : Double = 0
    // var dateAdded : Date = Date()
    
    init(coinId: String, amount: Double){
        self.coinId = coinId
        self.amount = amount
    }
    
    init(){}
    
//    //Failable initializer
//    init?(dictionary: [String: Any]){
//
//        guard let title = dictionary["bTitle"] as? String else{
//            return nil
//        }
//
//        guard let author = dictionary["bAuthor"] as? String else{
//            return nil
//        }
//
//        guard let isFiction = dictionary["bIsFiction"] as? Bool else{
//            return nil
//        }
//
//        self.init(title: title, author: author, fiction : isFiction )
//
//    }
}
