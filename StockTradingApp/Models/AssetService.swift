// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// get the api data through subscribing

import Foundation
import Combine

class AssetService  {
    
    @Published var allCoins : [CryptoModel] = []
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
        
    }
    
    
}
