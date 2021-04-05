import SwiftUI

struct RootView: View {
    @EnvironmentObject var userAuth: UserAuth

    let defaults = UserDefaults.standard

    var body: some View {
        Group {
            if userAuth.accessToken == nil {
                LoginView()
            } else {
                InvoiceListView()
            }
        }.onAppear(perform: {
            if userAuth.accessToken == nil {
                if let accessToken = defaults.string(forKey: "BellatrixToken") {
                    userAuth.accessToken = accessToken
                }
            }
        })
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environmentObject(UserAuth())
    }
}
