//
//  AssetService.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-12-04.
//

import Foundation
import Combine

class AssetService  {
    
    @Published var allCoins : [CryptoModel] = []
    // var cancellables = Set<AnyCancellable>()
    var assetsub : AnyCancellable?
    
    init() {
        getCoins()
    }
    private func getCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h")
        else { return }
        
        assetsub = NetworkingModel.download(url: url)
            .decode(type: [CryptoModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingModel.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.assetsub?.cancel()
            })
        
        
//        assetsub = URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .default))
//            .tryMap{ (output) -> Data in
//                guard let response = output.response as? HTTPURLResponse,
//                      response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return output.data
//            }
//            .receive(on: DispatchQueue.main)
//            .decode(type: [CryptoModel].self, decoder: JSONDecoder())
//            .sink{ (completion) in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//
//                }
//
//            } receiveValue: { [weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//                self?.assetsub?.cancel()
//            }
    }
    
    
}
