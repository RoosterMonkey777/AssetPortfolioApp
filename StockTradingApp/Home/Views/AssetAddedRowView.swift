// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// worked on by Zahaak

// the view that shows the users added list

import SwiftUI

struct AssetAddedRowView: View {
    @StateObject var homeViewModel = HomeViewModel.shared

    let asset : AssetDBModel
    let showHoldingsColumn : Bool
    let urlString : String
    
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
                        Text("\(asset.rank)")
                            .font(.headline)
                            .foregroundColor(Color.theme.secondary)
                            .frame(minWidth: 30)
                        
                            
                        Text(asset.symbol.uppercased())
                            .font(.headline)
                            .padding(.leading, 6)
                            .foregroundColor(Color.theme.primary)
                    }
                    
                    AssetImageView(urlString: urlString, data: nil)
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
    
                    
                    Text(asset.name.uppercased())
                        .font(.headline)
                        .foregroundColor(Color.theme.alien)
                }
                
            
                Spacer()

                // middle column if applicable
                if showHoldingsColumn {
                    VStack(alignment: .trailing){
                        Text("\(asset.amount.formatSharesHeld())")
                        Text(asset.currentCoinHoldingsValue.formatAssetPriceToTwo())
                            .bold()
                    }
                    .foregroundColor(Color.theme.primary)

                    
                }
                
                // riight column
                VStack(alignment: .trailing){
                    Text("\(asset.currentPrice.formatAssetPriceToSix())" )
                        .bold()
                        .foregroundColor(Color.theme.primary)
                    Text("\(asset.dailyChagePercentage.asPercentString()) %")
                        .foregroundColor(
                            (asset.dailyChagePercentage) <= 0 ?
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



//struct AssetAddedRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssetAddedRowView()
//    }
//}
