import PartialSheet
import SwiftUI

struct ContentView: View {
    let sheetManager = PartialSheetManager()

    var body: some View {
        RootView()
            .addPartialSheet()
            .environmentObject(UserAuth())
            .environmentObject(sheetManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
