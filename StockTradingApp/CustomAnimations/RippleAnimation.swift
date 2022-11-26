//
//  RippleAnimation.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-11-25.
//

import SwiftUI



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
