import SwiftUI

struct WorkflowDocument: View {
    var invoiceDetails: WorkflowDetails
    var formData = false

    @Environment(\.colorScheme) var colorScheme

    @State var errorDescription = ErrorDescription(showAlert: false, title: nil, description: nil)
    @State var downloadedFile = DownloadedFile()
    @State var showShareSheet = false

    func downloadDocument(invoice: WorkflowDetails) {
        provider.request(.downloadInvoiceDocument(documentId: invoice.DocumentId),
                         completion: {
                             result in
                             do {
                                 let file: DownloadedFile = try mapTo(result)
                                 self.downloadedFile = file
                             } catch {
                                 self.errorDescription = getErrorObject(error)
                             }
                         })
    }

    func downloadRemittanceSheet(invoice: WorkflowDetails) {
        provider.request(.downloadRemittanceSheet(invoiceId: invoice.DocumentId, formNames: invoice.FormNameList!.formNamesField),
                         completion: {
                             result in
                             do {
                                 let file: DownloadedFile = try mapTo(result)
                                 self.downloadedFile = file
                             } catch {
                                 self.errorDescription = getErrorObject(error)
                             }
                         })
    }

    var body: some View {
        RemotePDF(downloadedFile: downloadedFile)
            .onAppear(perform: {
                self.formData ? self.downloadRemittanceSheet(invoice: invoiceDetails) : self.downloadDocument(invoice: invoiceDetails)
            })
            .alert(isPresented: $errorDescription.showAlert) {
                Alert(title: Text(errorDescription.title!), message: Text(errorDescription.description!), dismissButton: .default(Text("Dismiss")))
            }.navigationBarItems(trailing:
                Button(action: {
                    self.showShareSheet.toggle()
                }) {
                    Image(systemName: "square.and.arrow.up").imageScale(.large)
                }.disabled(downloadedFile.fileName == "")
            )
            .navigationTitle(downloadedFile.fileName)
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(downloadedFile: self.downloadedFile)
            }
    }
}

struct WorkflowDocument_Previews: PreviewProvider {
    static var previews: some View {
        WorkflowDocument(invoiceDetails: Mocks.invoiceDetails)
    }
}
