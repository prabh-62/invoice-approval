import SwiftUI

struct InvoiceListView: View {
    @EnvironmentObject var userAuth: UserAuth

    @State var invoices = [Invoice]()
    @State var errorDescription = ErrorDescription(showAlert: false, title: nil, description: nil)

    func getInvoices() {
        provider.request(.invoices, completion: {
            result in
            do {
                let data: Invoices = try mapTo(result)
                invoices = data.WorkFlows
            } catch {
                self.errorDescription = getErrorObject(error)
            }
        })
    }

    func logOut() {
        provider.request(.logOut, completion: {
            result in
            do {
                let data: LogOutResponse = try mapTo(result)
                if data.IsLogout {
                    userAuth.accessToken = nil
                    let defaults = UserDefaults.standard
                    defaults.removeObject(forKey: "BellatrixToken")
                }
            } catch {
                self.errorDescription = getErrorObject(error)
                userAuth.accessToken = nil
                let defaults = UserDefaults.standard
                defaults.removeObject(forKey: "BellatrixToken")
            }
        })
    }

    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    List {
                        ForEach(invoices, id: \.self) { invoice in
                            NavigationLink(destination: InvoiceDetail(invoice: invoice)) {
                                VStack {
                                    InvoiceItem(invoice: invoice)
                                }
                                .padding(2)
                            }
                            .navigationBarTitle("Invoices")
                            .navigationTitle("Invoice Details")
                        }
                    }.onAppear(perform: {
                        self.getInvoices()
                    })
                    Button("Log out", action: {
                        self.logOut()
                    }).buttonStyle(ThemedButtonStyle(backgroundColor: .primaryColor))
                        .foregroundColor(.white)
                }
            }
            .alert(isPresented: $errorDescription.showAlert) {
                Alert(title: Text(errorDescription.title!), message: Text(errorDescription.description!), dismissButton: .default(Text("Dismiss"), action: {
                    self.logOut()
                }))
            }
        }
    }
}

struct InvoiceListView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceListView()
    }
}
