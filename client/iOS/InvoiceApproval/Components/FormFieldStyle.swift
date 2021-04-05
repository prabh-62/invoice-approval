import SwiftUI

struct FormFieldStyle: TextFieldStyle {
    @Environment(\.colorScheme) var colorScheme

    public func _body(configuration: TextField<Self._Label>) -> some View {
        return configuration
            .padding(.top, 10)
            .padding(.bottom, 10)
            .padding(.leading, 10)
            .cornerRadius(5.0)
            .background(colorScheme == .dark ? .black : Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
            .border(envColor(colorScheme), width: colorScheme == .dark ? 1 : 0)
    }
}
