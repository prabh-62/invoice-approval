import SwiftUI

struct ThemedButtonStyle: ButtonStyle {
    var backgroundColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 180)
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .textCase(.uppercase)
            .font(.system(size: 16, weight: .bold))
            .background(backgroundColor)
            .cornerRadius(4)
            .animation(.spring())
    }
}
