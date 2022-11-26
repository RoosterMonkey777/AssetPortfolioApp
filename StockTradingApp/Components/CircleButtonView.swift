// Circle button used as interface for various navigation bar items

import SwiftUI

struct CircleButtonView: View {
    
    let iconToUse: String
    
    var body: some View {
        Image(systemName: iconToUse)
            .foregroundColor(Color.theme.alien)
            .font(.title2)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(
                color: Color.theme.alien.opacity(0.4),
                radius: 10, x:0, y:0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CircleButtonView(iconToUse: "person.fill")
            CircleButtonView(iconToUse: "person.fill")
                .preferredColorScheme(.dark)
        }
    }
}
