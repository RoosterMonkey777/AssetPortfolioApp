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
