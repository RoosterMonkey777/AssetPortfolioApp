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
    
    static let shared = HomeViewModel()
    
    @Published var cryptoList = [CryptoModel]()
    
    @Published var allCryptocurrencies : [CryptoModel] = []
    @Published var portfolioCryptoCurrencies : [CryptoModel] = []
    
    init() {
        // call the api through dispathqueue
        fetchCryptoCurrencyApi()
    }
    
    func fetchCryptoCurrencyApi(){
        
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
                      
                                        DispatchQueue.main.async {
                                            //self.allCryptocurrencies.append(contentsOf: decodedCrypto)
                                            //self.portfolioCryptoCurrencies.append(contentsOf: decodedCrypto)
                                            self.cryptoList = decodedCrypto
                                            self.allCryptocurrencies.append(contentsOf: decodedCrypto)
                                            
                                            
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
    
    /*
     {
         
         
         
         let task = URLSession.shared.dataTask(with: api){ (data: Data?, response: URLResponse?, error: Error?) in
             
             if let error = error{
                 print(#function, "Unable to connect to Web Services: \(error)")
             }else{
                 
                 if let httpResponse = response as? HTTPURLResponse{
                     if httpResponse.statusCode == 200{
                         //200 response OK
                         
                         DispatchQueue.global().async {
                             do{
                                 
                                 if (data != nil){
                                     
                                     if let jsonData = data{
                                         
                                         //perform decoding
                                         let decoder = JSONDecoder()
                                         
 //                                        //decoder tries to find single object
 //                                        let decodedLaunchList = try decoder.decode(Launch.self, from: jsonData)
                                         //decoder tries to find array of objects
                                         var decodedLaunchList = try decoder.decode([Launch].self, from: jsonData)
                                         print(#function, decodedLaunchList)
                                         
                                         //try to obtain image from URL
                                         //complete the object creation only if image is available
                                         //or if when we find that no image is present
                                         
                                         for launchObj in decodedLaunchList{
                                             
                                             if(launchObj.imageURL != nil){
                                                 self.fetchImage(from: launchObj.imageURL!, withCompletion: {data in
                                                     
                                                     guard let imageData = data else{
                                                         print(#function, "Image data not obtained")
                                                         return
                                                     }
                                                     
                                                     //find matching object
                                                     guard let index = decodedLaunchList.firstIndex(where: {$0.id == launchObj.id}) else{
                                                         return
                                                     }
                                                         
                                                     //initialize image property of Launch structure
                                                     decodedLaunchList[index].image = UIImage(data: imageData)
                                                     
                                                     DispatchQueue.main.async {
                                                         self.launchList = decodedLaunchList
                                                     }
                                                     
                                                 })
                                                 
                                             }//if ends
                                         }//for ends
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
                 }else{
                     print(#function, "Unable to receive any response from network call")
                 }//else
             }//else
             
         }//URLSession.shared.dataTask()
         
         task.resume()
     }
     */
    
}
