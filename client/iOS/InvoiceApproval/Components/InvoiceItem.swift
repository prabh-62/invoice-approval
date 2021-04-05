import SwiftUI

struct InvoiceItem: View {
    var invoice: Invoice

    var body: some View {
        VStack {
            HStack {
                Text("Invoice").textCase(.uppercase).font(.system(size: 14, weight: .bold))
                Spacer()
                Text(invoice.CustomerName ?? "").font(.subheadline)
            }
            HStack {
                Text(invoice.OrderNumber ?? "").padding(.leading, 20).padding(.top, 10).font(.subheadline)
                Spacer()
                Text(invoice.StringDate ?? "").font(.subheadline)
            }
        }.padding(5)
    }
}

struct InvoiceItem_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceItem(invoice: Invoice())
    }
}
