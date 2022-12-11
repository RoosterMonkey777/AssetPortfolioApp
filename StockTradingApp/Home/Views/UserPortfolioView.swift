//
//  UserPortfolioView.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-12-10.
//

import SwiftUI

struct UserPortfolioView: View {
    
    @Environment(\.presentationMode) var pm
    @EnvironmentObject private var viewModel : HomeViewModel
    
    
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
                                            .fill(Color.theme.background)
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
                                        
                                }
                            }
                        }
                        )
                    }
                    
                    
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
            }
        }
        
    }
}

struct UserPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        UserPortfolioView()
            .environmentObject(shared_dev.homeVM)
    }
}
