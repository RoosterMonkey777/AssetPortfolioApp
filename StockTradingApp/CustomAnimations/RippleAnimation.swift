// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// worked on by Shareef

// Ripple animation for when button is circular button ispressed

import SwiftUI

struct RippleAnimation: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none, value: animate)
    }
}

struct RippleAnimation_Previews: PreviewProvider {
    static var previews: some View {
        RippleAnimation(animate: .constant(false))
    }
}
