// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// worked on by zahaak

// the users portfolio screen where they can browse and add assets

import SwiftUI

struct UserPortfolioView: View {
    
    @Environment(\.presentationMode) var pm
    @EnvironmentObject private var viewModel : HomeViewModel
    @EnvironmentObject var fireDBHelper : FireDBHelper

    
    @State var selectedAsset : CryptoModel? = nil
    @State var quantity : String = "0"
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(){
                    Text("Browse and add various equities, crypto, indices, and much more!")
                        .frame(width: 350)
                        .font(.subheadline)
                        .padding(.top)
                    SearchBarView(searchText: $viewModel.searchText)
                    VStack(alignment: .leading){
                        Text("crypto")
                            .foregroundColor(Color.theme.secondary)
                            .padding(.leading).padding(.leading)
                            
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            LazyHStack(alignment: .top,spacing: -10){
                                ForEach(viewModel.allCoins) { asset in
                                   
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .fill(selectedAsset?.id == asset.id ? Color.theme.secondary : Color.theme.background)
                                            .frame(maxWidth: 120, minHeight: 120)
                                            .shadow(color:Color.theme.alien,radius: 5)
                                        
                                        VStack(alignment: .center, spacing: 15){
                                                Text(asset.symbol.uppercased())
                                                    .font(.headline)
                                                    .padding(.leading, 6)
                                                    .foregroundColor(Color.theme.primary)
  
                                            AssetImageView(urlString: asset.image, data: nil)
                                                .frame(width: 50, height: 50)
                                                .padding(.horizontal)
                                                                
                                        }
                                        
                                    }
                                    .padding()
                                    .onTapGesture {
                                        withAnimation(.easeIn){
                                            selectedAsset = asset
                                        }
                                    }
                                }
                            }
                        }
                        )
                        
                        if selectedAsset != nil{
                            Section("\(selectedAsset?.name.uppercased() ?? "") Statistics:", content: {
                               
                                VStack{
                                   HStack{
                                       Text("\(selectedAsset?.symbol.uppercased() ?? "") Price :")
                                       Spacer()
                                       Text("\(selectedAsset?.current_price.formatAssetPriceToSix() ?? "0.00") CAD")
                                           .fontWeight(.semibold)
                                   }.padding(.top)
                                   
                                   
                                   Divider()
                                   
                                   HStack{
                                       Text("\(selectedAsset?.symbol.uppercased() ?? "") Rank :")
                                       Spacer()
                                       Text("\(selectedAsset?.getRank ?? 0) ").fontWeight(.semibold)
                                   }
                                   
                                   Divider()
                                   
                                   HStack{
                                       Text("Daily Change % :")
                                       Spacer()
                                       Text("\(selectedAsset?.price_change_percentage_24h?.asPercentString() ?? "0%") ")
                                           .fontWeight(.semibold)
                                           .foregroundColor((selectedAsset?.price_change_percentage_24h ?? 0) >= 0 ? Color.theme.bull : Color.theme.bear)
                                   }
                                   
                                   Divider()
                                   
                                  

                                   
                                   HStack{
                                       Text("Shares Held :")
                                       Spacer()
                                      TextField("10", text: $quantity)
                                           .fontWeight(.semibold)
                                           .multilineTextAlignment(.trailing)
                                           .keyboardType(.decimalPad)
                                   }
                                   
                                   Divider()
                                    
                                    HStack{
                                        Text("Position Value :")
                                        Spacer()
                                        Text(getAssetValue().formatAssetPriceToTwo())
                                            .fontWeight(.heavy)
                                    }
                                   
                                   
                                   
                                   
                               }
                                .animation(.none)
                            }).padding(.horizontal).padding(.horizontal).padding(.top)
                        }
                    } // end Big Vstack
                }
                .foregroundColor(Color.theme.alien)
            }
            .navigationTitle("Edit Asset Portfolio")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        pm.wrappedValue
                            .dismiss()
                    }, label: {
                        Image(systemName: "x.square")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.primary)
                    })
                   
                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        saveHoldings()
                    }, label: {
                        Image(systemName: "square.and.arrow.down")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.primary)
                    })
                    .opacity( ( selectedAsset != nil && selectedAsset?.coinHoldings != Double(quantity)) ?  1 : 0)
                   
                }
            }
        }
        
    }
    private func saveHoldings() {
        guard let asset = selectedAsset
        else {return}
        
        let newAsset = AssetDBModel(coinId: asset.id, name: asset.name, rank: asset.getRank, symbol: asset.symbol, currentPrice: asset.current_price, dailyChangePercentage: (asset.price_change_percentage_24h ?? 0), imageString: asset.image, amount: (Double(quantity) ?? 0))
        self.fireDBHelper.insertAsset(newAsset: newAsset)
        
        
        //dismiss currently presented view
        //dismiss()
        
        selectedAsset = nil
        viewModel.searchText = ""
        UIApplication.shared.dismissKeyboard()
    }
    
    private func getAssetValue() -> Double {
        let userQuantity = Double(quantity)
        return (userQuantity ?? 0) * (selectedAsset?.current_price ?? 0)
    }
}

//struct UserPortfolioView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserPortfolioView()
//            .environmentObject(shared_dev.homeVM)
//    }
//}
