import SwiftUI

struct Log: View {
    @Environment(\.colorScheme) var colorScheme

    var annotation: DocumentLog
    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading, spacing: nil) {
                    Text("\(Image(systemName: "person")) \(annotation.Creator ?? "")")
                    Text("\(annotation.Created ?? Date(), style: .relative) ago")
                        .font(.caption2)
                        .padding(.leading, 25)
                    Text(annotation.Text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
                        .font(.subheadline)
                        .padding(.top, 4)
                        .padding(.leading, 25)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(6)
                .padding(.leading, 10)
            }
        }
        .border(envColor(colorScheme), width: 1)
        .padding(2)
    }
}

struct Log_Previews: PreviewProvider {
    static var previews: some View {
        Log(annotation: DocumentLog())
    }
}
