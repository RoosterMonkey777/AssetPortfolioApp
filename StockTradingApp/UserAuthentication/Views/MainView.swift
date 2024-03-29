// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// workded on by Zahaak

// checks which state the app is in to determine authentcaion state

import SwiftUI
import Firebase

struct MainView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    let fireDBHelper = FireDBHelper(database: Firestore.firestore())
    
    var body: some View {
        switch viewRouter.currentPage {
        case .signUpPage:
            SignUpView()
        case .signInPage:
            SignInView()
        case .homePage:
            HomeView()
                .environmentObject(fireDBHelper)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewRouter())
    }
}

