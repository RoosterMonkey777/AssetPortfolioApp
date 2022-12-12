// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// worked on by Zahaak

// a search bar view

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText : String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondary : Color.theme.alien
                )
            
            
            TextField("Search ticker or name...", text: $searchText)
                .foregroundColor(Color.theme.alien)
                .overlay(
                    Image(systemName: "x.circle")
                        .padding()
                        .offset(x: 10)
                        .font(.title2)
                        .foregroundColor(Color.theme.alien)
                        .opacity(searchText.isEmpty ? 0.0 : 0.80)
                        .onTapGesture {
                            UIApplication.shared.dismissKeyboard()
                            searchText = ""
                            
                        }
                        
                    ,alignment: .trailing
                )
                .autocorrectionDisabled(true)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.alien.opacity(0.80),
                    radius: 5
                )
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
