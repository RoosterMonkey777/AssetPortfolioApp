// used to import our custom colors into the app

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
}
