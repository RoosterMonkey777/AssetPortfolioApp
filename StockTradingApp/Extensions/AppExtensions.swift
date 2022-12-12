// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// Worked on by both

// extensions used throughout the app for colors, formatting stirngs, etc.

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let primary = Color("AccentColor")
    let secondary = Color("Secondary")
    let background = Color("Background")
    let bear = Color("Red") // want special red for when price % < 0
    let bull = Color("Green") // want special red for when price % > 0
    let alien = Color("Alien")
    let buttoncolor1 = Color("ButtonColor1")
}

// for custom currency
extension Double {
    
    
    private var sharedHeld : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = .current
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        
        return formatter
    }
    
    func formatSharesHeld() -> String {
        let number = NSNumber(value: self)
        return sharedHeld.string(from: number) ?? "0"
    }
    
    private var currencyFormatter2 : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = .current
        formatter.currencyCode = "cad"
        formatter.currencySymbol = "$"
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        
        return formatter
    }
    
    func formatAssetPriceToTwo() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "0.00"
    }
    
    private var currencyFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 5
        formatter.currencyCode = "cad"
        formatter.currencySymbol = "$"
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        return formatter
    }
    func formatAssetPriceToSix() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "0.00"
    }
    
    // formet to percent string
    func formatToPercentString() -> String {
        return String(format: "%.2f", self)
    }
    
    // change to percent
    func asPercentString() -> String {
            return formatToPercentString() + "%"
        }
    
}

// to get rid of the keyboard from 'x' tap gesture on search bar
extension UIApplication{
    
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
