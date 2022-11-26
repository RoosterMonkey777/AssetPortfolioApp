//
//  ViewRouter.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-11-26.
//

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .signInPage
}

enum Page {
    case signUpPage
    case signInPage
    case homePage
}
