//
//  HomeViewModel.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-11-28.
//

import Foundation
import UIKit

class HomeViewModel: ObservableObject {
    
    var apiURL : String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
    //var apiURL : String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_desc&per_page=3&page=1&sparkline=true&price_change_percentage=24h"
    
    static let shared = HomeViewModel()
    
    @Published var cryptoList = [CryptoModel]()
    
    @Published var allCryptocurrencies : [CryptoModel] = []
    @Published var portfolioCryptoCurrencies : [CryptoModel] = []
    
    init() {
        // call the api through dispathqueue
        fetchCryptoCurrencyApi()
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
                                        
                                            //print(#function, decodedCrypto)
                                        
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
    

    
}
