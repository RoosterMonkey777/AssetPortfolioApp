//
//  AssetImageView.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-11-29.
//

import SwiftUI

struct AssetImageView : View {
    let urlString : String
    @State var data : Data?
    
    
    var body : some View{
        if let data = data, let image = UIImage(data:data){
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                #if os(watchOS)
                .frame(width: 25, height: 25)
                #else
                .frame(width: 50, height: 50)
                #endif
                .scaledToFit()
                .onAppear{
                    fetchImageData()
                }
                
        } else {
            ProgressView()
                .onAppear{
                    fetchImageData()
                }
        }
    }
    
    func fetchImageData() {
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, _,_ in
            DispatchQueue.main.async {
                self.data = data

            }
        }
        task.resume()
    }
    
}



//struct AssetImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetImageView(urlString: nil)
//    }
//}
