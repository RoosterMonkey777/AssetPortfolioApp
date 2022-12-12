// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// worked on by shareef

// The various pages that the app can take

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .signInPage
}

enum Page {
    case signUpPage
    case signInPage
    case homePage
}
