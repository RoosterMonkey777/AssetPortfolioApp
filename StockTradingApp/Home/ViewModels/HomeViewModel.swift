// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// Worked on by Zahaak

// This consists of helper functions that call api the apis and set up a viewmodel for the home screen
import SwiftUI
import Foundation
import UIKit
import Combine


class HomeViewModel: ObservableObject {
    
    var apiURL : String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
    var WatchapiURL : String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_desc&per_page=3&page=1&sparkline=true&price_change_percentage=24h"
    
    static let shared = HomeViewModel()
    @Published var allCoins : [CryptoModel] = []
    private let ds = AssetService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var searchText: String = ""
    
    @Published var cryptoList = [CryptoModel]()
    @Published var allCryptocurrencies : [CryptoModel] = []
    @Published var portfolioCryptoCurrencies : [CryptoModel] = []
    
    @Published var cryptoWatchList = [CryptoModel]()
    @Published var allWatchCryptocurrencies : [CryptoModel] = []
    @Published var portfolioWatchCryptoCurrencies : [CryptoModel] = []
    
    @Published var  markets : [MarketTabModel] = [
        MarketTabModel(header: "AAPL", val: "$142.16", percChange: -0.34),
        MarketTabModel(header: "S&P 500", val: "$3,934.38", percChange: -0.73),
        MarketTabModel(header: "MSFT", val: "$245.42", percChange: 0.8),
        MarketTabModel(header: "NASDAQ", val: "$11,004.62", percChange: 0.70)
    ]
    
    init() {
        // call the api through dispathqueue
        fetchCryptoWatchCurrencyApi()
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
    
    //fetching the data for the WatchApp
    private func fetchCryptoWatchCurrencyApi(){
            
            print("Fetching data from Coingecko API")
            guard let api = URL(string: WatchapiURL) else {
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
                                            
                                               
                                            DispatchQueue.main.async {
                                                self.cryptoWatchList = decodedCrypto
                                                self.allWatchCryptocurrencies.append(contentsOf: decodedCrypto)
                                                self.portfolioWatchCryptoCurrencies.append(contentsOf: decodedCrypto)
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
