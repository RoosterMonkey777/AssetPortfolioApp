//
//  HomeViewModel.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-11-28.
//
import SwiftUI
import Foundation
import UIKit
import Combine


class HomeViewModel: ObservableObject {
    
    var apiURL : String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
    //var apiURL : String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_desc&per_page=3&page=1&sparkline=true&price_change_percentage=24h"
    
    static let shared = HomeViewModel()
    @Published var allCoins : [CryptoModel] = []
    private let ds = AssetService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchText: String = ""
    
    @Published var cryptoList = [CryptoModel]()
    @Published var allCryptocurrencies : [CryptoModel] = []
    @Published var portfolioCryptoCurrencies : [CryptoModel] = []
    
    @Published var  markets : [MarketTabModel] = [
        MarketTabModel(header: "title 1", val: "value 1", percChange: 10.0),
        MarketTabModel(header: "title 2", val: "value 2"),
        MarketTabModel(header: "title 3", val: "value 3", percChange: -13.2),
        MarketTabModel(header: "title 4", val: "value 4", percChange: 3.2)
    ]
    
    init() {
        // call the api through dispathqueue
        // fetchCryptoCurrencyApi()
        addEventListener()
    }
    
    func addEventListener() {
        

        
        $searchText
            .combineLatest(ds.$allCoins)
            .map { (text, start) -> [CryptoModel] in
               
                guard !text.isEmpty else {
                    return start
                }
                
                let lowercasedText = text.lowercased()
                
                let filteredAssets = start.filter { asset -> Bool in
                    return asset.name.lowercased().contains(lowercasedText) ||
                    asset.symbol.lowercased().contains(lowercasedText) ||
                    asset.id.lowercased().contains(lowercasedText)
                }
                return filteredAssets
            }
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    
    private func fetchCryptoCurrencyApi(){
        
        print("Fetching data from Coingecko API")
        guard let api = URL(string: apiURL) else {
            print(#function, "Error retrieving URL from string")
            return
        }
        
        let task = URLSession.shared.dataTask(with: api){ (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                print(#function, "Unable to connect to Web Services: \(error)")
            } else {
                
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200{
                        //200 response OK
                        DispatchQueue.global().async{
                            do{
                                
                                if (data != nil){
                                    
                                    if let jsonData = data{
                                        
                                        //perform decoding
                                        let decoder = JSONDecoder()
                                        
                                        //decoder tries to find single object
                                        let decodedCrypto = try decoder.decode([CryptoModel].self, from: jsonData)
                                        
                                        print(#function, decodedCrypto)
                                        
//                                        for assetObj in decodedCrypto{
//                                            if(assetObj.image != nil){
//                                                self.fetchImage(from: assetObj.image, withCompletion: {data in
//
//                                                    guard let imageData = data else{
//                                                        print(#function, "Image data not obtained")
//                                                        return
//                                                    }
//
//                                                    //find matching object
//                                                    guard let index = decodedCrypto.firstIndex(where: {$0.id == assetObj.id}) else{
//                                                        return
//                                                    }
//
//                                                    //initialize image property of Launch structure
//                                                    decodedCrypto[index].image = UIImage(data: imageData)
//
//                                                    DispatchQueue.main.async {
//                                                        self.cryptoList = decodedCrypto
//                                                    }
//
//                                                })
//
//                                            }
//                                        }
                                        
                                        DispatchQueue.main.async {
                                            self.cryptoList = decodedCrypto
                                            self.allCryptocurrencies.append(contentsOf: decodedCrypto)
                                            self.portfolioCryptoCurrencies.append(contentsOf: decodedCrypto)
                                        }
                                        
                                    }else{
                                        print(#function, "Unable to obtain jsonData")
                                    }
                                }else{
                                    print(#function, "No data with response code 200")
                                }
                            }catch let error{
                                print(#function, "No data received \(error)")
                            }
                        }

                    }else{
                        print(#function, "HTTP Response status code : \(httpResponse.statusCode)")
                    }
                    
                }else {
                    print(#function, "Unable to receive any response from network call")
                }
            }
        }
        task.resume()
        
    }
    
    private func fetchImage(from url : URL, withCompletion completion: @escaping (Data?) -> Void){
        //network request
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if let error = error{
                print(#function, "Unable to connect to Web Services for images: \(error)")
            }else{
                
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200{
                        
                        if (data != nil){
                            
                            DispatchQueue.main.async {
                                completion(data)
                            }
                            
                        }
                    }
                }
            }
            
        })
        task.resume()
    }
}
