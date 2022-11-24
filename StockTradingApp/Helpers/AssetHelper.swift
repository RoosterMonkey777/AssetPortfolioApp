import Foundation
import UIKit

class AssetHelper : ObservableObject {
    
    @Published var asset : Asset?
    
    var apiUrl : String = "https://api.twelvedata.com/time_series?apikey=fb195ed54dbf484993db9ecc94f816e5&interval=5min&country=US&format=JSON&previous_close=true&symbol=AAPL&outputsize=100"
    
    init(){
        self.fetchDataFromApi()
    }
    
    private func fetchDataFromApi(){
        
        print("Fetching data from TwelveData - API")
        
        guard let api = URL(string: apiUrl) else {
            print(#function, "Unable to obtain URL from string")
            return
        }
        
        let task = URLSession.shared.dataTask(with: api){ data, response, error in
            
            if let error = error{
                print(#function, "There was a problem connecting to web services: \(error.localizedDescription)")
                return
            }
            else {
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200{
                        DispatchQueue.global().async {
                            do{
                                if data != nil {
                                    if let jsonData = data{
                                        let decodedAsset = try JSONDecoder().decode(Asset.self, from: jsonData)
                                        print(decodedAsset.symbol)
                                        print(decodedAsset.exchange)
                                        print(decodedAsset.interval)
                                        print(decodedAsset.type)
                                    } else {
                                        print(#function, "Unable tot convert to jsonData")
                                    }
                                } else {
                                    print(#function, "Unable to reieve any data")
                                }
                            } catch let error {
                                print(#function, "No data recieved \(error)")
                            }
                        } // end dispatchqueue
                    } else {
                        print(#function, "HTTP Resposne statuscode: \(httpResponse.statusCode)")
                    }
                } else {
                    print(#function, "Unable to receive response from network call")
                    return
                } // else httpresponse
            } // else error
        }
        task.resume()
    }
}
