// API URL to get coin data : https://api.coingecko.com/api/v3/coins/markets?vs_currency=cad&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h
/*
 { Sample json res:
 
     "id": "ethereum",
     "symbol": "eth",
     "name": "Ethereum",
     "image": "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880",
     "current_price": 1576.85,
     "market_cap": 190016249005,
     "market_cap_rank": 2,
     "fully_diluted_valuation": 190016249005,
     "total_volume": 9058617122,
     "high_24h": 1631.57,
     "low_24h": 1556.3,
     "price_change_24h": -49.3999837537317,
     "price_change_percentage_24h": -3.03765,
     "market_cap_change_24h": -6517460797.61322,
     "market_cap_change_percentage_24h": -3.31621,
     "circulating_supply": 120519279.806846,
     "total_supply": 120519279.806846,
     "max_supply": null,
     "ath": 6108.18,
     "ath_change_percentage": -74.18339,
     "ath_date": "2021-12-01T08:38:24.623Z",
     "atl": 0.561954,
     "atl_change_percentage": 280514.8063,
     "atl_date": "2015-10-20T00:00:00.000Z",
     "roi": {
       "times": 95.62968594362573,
       "currency": "btc",
       "percentage": 9562.968594362574
     },
     "last_updated": "2022-11-28T19:40:47.923Z",
     "sparkline_in_7d": {
       "price": [
         1110.6282618641987,
         1103.2095169168558,
       ]
     },
     "price_change_percentage_24h_in_currency": -3.0376536497892848
   }
 
 
 */
import Foundation

struct CryptoModel : Identifiable, Codable {

    let id, symbol, name: String
    let image: String
    let current_price: Double
    let market_cap: Double?
    let market_cap_rank: Double?
    let fully_diluted_valuation: Double?
    let total_volume: Double?
    let high_24h : Double?
    let low_24H : Double?
    let price_change_24h: Double?
    let price_change_percentage_24h: Double?
    let market_cap_change_24h: Double?
    let market_cap_change_percentage_24h: Double?
    let circulating_supply: Double?
    let total_supply: Double?
    let max_supply: Double?
    let ath: Double?
    let ath_change_percentage: Double?
    let ath_date: String?
    let atl:Double?
    let atl_change_percentage: Double?
    let atl_date: String?
    let last_updated: String?
    let sparkline_in_7d: SparklineIn7D?
    let price_change_percentage_24h_in_currency: Double?
    let coinHoldings: Double? // added on to add functionality on how many coins the user is holding
    
    enum CryptoKeys: String, CodingKey {
        case id, symbol, name
        case image
        case current_price
        case market_cap
        case market_cap_rank
        case fully_diluted_valuation
        case total_volume
        case high_24h
        case low_24h
        case price_change_24h
        case price_change_percentage_24h
        case market_cap_change_24h
        case market_cap_change_percentage_24h
        case circulating_supply
        case total_supply
        case max_supply
        case ath
        case ath_change_percentage
        case ath_date
        case atl
        case atl_change_percentage
        case atl_date
        case last_updated
        case sparkline_in_7d
        case price_change_percentage_24h_in_currency
        case coinHoldings
    }
    
//    init(from decoder: Decoder, amount: Double) throws {
//
//        let container = try decoder.container(keyedBy: CryptoKeys.self)
//
//        self.id = try container.decode(String.self, forKey: .id)
//        self.symbol = try container.decode(String.self, forKey: .symbol)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.image = try container.decode(String.self, forKey: .image)
//        self.currentPrice = try container.decode(Double.self, forKey: .currentPrice)
//
//        self.marketCap = try container.decodeIfPresent(Double.self, forKey: .marketCap)
//        self.marketCapRank = try container.decodeIfPresent(Double.self, forKey: .marketCapRank)
//        self.fullyDilutedValuation = try container.decodeIfPresent(Double.self, forKey: .fullyDilutedValuation)
//        self.totalVolume = try container.decodeIfPresent(Double.self, forKey: .totalVolume)
//        self.high24H = try container.decodeIfPresent(Double.self, forKey: .high24H)
//        self.low24H = try container.decodeIfPresent(Double.self, forKey: .low24H)
//        self.priceChange24H = try container.decodeIfPresent(Double.self, forKey: .priceChange24H)
//        self.priceChangePercentage24H = try container.decodeIfPresent(Double.self, forKey: .priceChangePercentage24H)
//        self.marketCapChange24H = try container.decodeIfPresent(Double.self, forKey: .marketCapChange24H)
//        self.marketCapChangePercentage24H = try container.decodeIfPresent(Double.self, forKey: .marketCapChangePercentage24H)
//        self.circulatingSupply = try container.decodeIfPresent(Double.self, forKey: .circulatingSupply)
//        self.totalSupply = try container.decodeIfPresent(Double.self, forKey: .totalSupply)
//        self.maxSupply = try container.decodeIfPresent(Double.self, forKey: .maxSupply)
//        self.ath = try container.decodeIfPresent(Double.self, forKey: .ath)
//        self.athChangePercentage = try container.decodeIfPresent(Double.self, forKey: .athChangePercentage)
//        self.athDate = try container.decodeIfPresent(String.self, forKey: .athDate)
//        self.atl = try container.decodeIfPresent(Double.self, forKey: .atl)
//        self.atlChangePercentage = try container.decodeIfPresent(Double.self, forKey: .atlChangePercentage)
//        self.atlDate = try container.decodeIfPresent(String.self, forKey: .atlDate)
//        self.lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated)
//        self.sparklineIn7D = try container.decodeIfPresent(SparklineIn7D.self, forKey: .sparklineIn7D)
//        self.priceChangePercentage24HInCurrency = try container.decodeIfPresent(Double.self, forKey: .priceChangePercentage24HInCurrency)
//        self.coinHoldings = amount
//    }

//    func updateCoinHoldings(amount: Double) -> CryptoModel {
//        return self
//    }
    
    func updateCoinHolding(amount: Double) -> CryptoModel{
        return CryptoModel(id: id, symbol: symbol, name: name, image: image, current_price: current_price, market_cap: market_cap, market_cap_rank: market_cap_rank, fully_diluted_valuation: fully_diluted_valuation, total_volume: total_volume, high_24h: high_24h, low_24H: low_24H, price_change_24h: price_change_24h, price_change_percentage_24h: price_change_percentage_24h, market_cap_change_24h: market_cap_change_24h, market_cap_change_percentage_24h: market_cap_change_percentage_24h, circulating_supply: circulating_supply, total_supply: total_supply, max_supply: max_supply, ath: ath, ath_change_percentage: ath_change_percentage, ath_date: ath_date, atl: atl, atl_change_percentage: atl_change_percentage, atl_date: atl_date, last_updated: last_updated, sparkline_in_7d: sparkline_in_7d, price_change_percentage_24h_in_currency: price_change_percentage_24h_in_currency, coinHoldings: amount
        )
    }

    var getRank : Int {
        return Int(market_cap_rank ?? 0)
    }

    var currentCoinHoldingsValue : Double {
        return current_price  * (coinHoldings ?? 0)
    }
    
//    func updateCoin() -> CryptoModel{
//        return CryptoModel(id: id, symbol: symbol, name: name)
//    }
}

struct SparklineIn7D : Codable {
    let price: [Double]?
}



