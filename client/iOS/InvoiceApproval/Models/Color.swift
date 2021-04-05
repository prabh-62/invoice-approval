import SwiftUI

public extension Color {
    static let primaryColor = Color("PrimaryColor") // Color that we have set in Assets catalog
    static let secondary = Color("AccentColor")
}

func envColor(_ scheme: ColorScheme) -> Color {
    return scheme == .dark ? .white : .black
}
