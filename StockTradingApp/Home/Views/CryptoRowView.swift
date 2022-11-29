import SwiftUI

struct CryptoRowView: View {
    
    let crypto : CryptoModel
    let showHoldingsColumn : Bool
    
    var body: some View {
        
        ZStack{
            
            // background container
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.theme.background)
                .frame(maxWidth: .infinity, maxHeight: 200)
                .shadow(color:Color.theme.alien,radius: 5)
                
                
            
            HStack(spacing: 0){
                
                // left column
                VStack(alignment: .center, spacing: 15){
                    HStack (alignment: .top){
                        Text("\(crypto.getRank)")
                            .font(.headline)
                            .foregroundColor(Color.theme.secondary)
                            .frame(minWidth: 30)
                        
                            
                        Text(crypto.symbol.uppercased())
                            .font(.headline)
                            .padding(.leading, 6)
                            .foregroundColor(Color.theme.primary)
                    }
                    
                    Circle()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                    
                    Text(crypto.name.uppercased())
                        .font(.headline)
                        .foregroundColor(Color.theme.alien)
                }
                
            
                Spacer()

                // middle column if applicable
//                if showHoldingsColumn {
//                    VStack(alignment: .trailing){
//                        Text(crypto.currentCoinHoldingsValue.formatAssetPriceToTwo())
//                            .bold()
//                        Text((crypto.coinHoldings ?? 0).formatAssetPriceToSix())
//
//
//                    }
//                    .foregroundColor(Color.theme.primary)
//
//
//                }
                
                // riight column
                VStack(alignment: .trailing){
                    Text("\(crypto.currentPrice?.formatAssetPriceToSix() ?? "")" )
                        .bold()
                        .foregroundColor(Color.theme.primary)
                    Text("\(crypto.priceChangePercentage24H?.formatToPercentString() ?? "") %")
                        .foregroundColor(
                            (crypto.priceChangePercentage24H ?? 0) <= 0 ?
                            Color.theme.bear :
                            Color.theme.bull
                        )
                }.frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing) //1/3 of the screen
            }
            .font(.subheadline)
            .padding()
            
        }
        
        .padding(.top)
    }
}

//struct CryptoRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CryptoRowView(crypto: shared_dev.crypto, showHoldingsColumn: true)
//    }
//}


