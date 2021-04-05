import PartialSheet
import SwiftUI

struct InvoiceDetail: View {
    var invoice: Invoice
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var errorDescription = ErrorDescription(showAlert: false, title: nil, description: nil)
    @State var invoiceDetails = WorkflowDetails()
    
    @State var showCommentBox = false
    @State var comment = ""
    
    @State var actionNames = WorkflowActionNamesResponse()
    
    func getInvoiceDetails(invoiceId: String) {
        provider.request(.invoiceDetails(invoiceId: invoiceId),
                         completion: {
                             result in
                             do {
                                 let data: InvoiceDetails = try mapTo(result)
                                 self.invoiceDetails = data.WorkFlowDetails
                             } catch {
                                 self.errorDescription = getErrorObject(error)
                             }
                         })
    }
    
    func getActionNames(invoiceId: String) {
        provider.request(.actionNames(invoiceId: invoiceId),
                         completion: {
                             result in
                             do {
                                 let actionNames: WorkflowActionNamesResponse = try mapTo(result)
                                 self.actionNames = actionNames
                                 print(actionNames)
                             } catch {
                                 self.errorDescription = getErrorObject(error)
                             }
                         })
    }
    
    func addComment(documentId: String, comment: String) {
        provider.request(.addComment(documentId: documentId, comment: DocumentComment(feedback: comment.trimmingCharacters(in: .whitespacesAndNewlines))),
                         completion: {
                             result in
                             do {
                                 let response: DocumentCommentResponse = try mapTo(result)
                                 if response.IsSubmitted {
                                     self.showCommentBox = false
                                     self.comment = ""
                                     self.getInvoiceDetails(invoiceId: invoice.DocumentId)
                                 }
                             } catch {
                                 self.errorDescription = getErrorObject(error)
                             }
                         })
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("Invoice:")
                    Spacer()
                    Text(invoiceDetails.Invoice ?? "").fontWeight(.bold)
                }
                HStack {
                    Text("Vendor:")
                    Spacer()
                    Text(invoiceDetails.Vendor ?? "").fontWeight(.bold)
                }
                HStack {
                    Text("Date:")
                    Spacer()
                    Text(invoiceDetails.Date ?? Date(), style: .date).fontWeight(.bold)
                }
                HStack {
                    Text("Purchase Amount:")
                    Spacer()
                    Text("$\(String(format: "%.2f", invoiceDetails.PurchaseAmount ?? 0.0))").fontWeight(.bold)
                }
                HStack {
                    Text("Cost Center:")
                    Spacer()
                    Text(invoiceDetails.CostCenter ?? "").fontWeight(.bold)
                }
            }.padding(10).padding(.horizontal, 10)
                .alert(isPresented: $errorDescription.showAlert) {
                    Alert(title: Text(errorDescription.title!), message: Text(errorDescription.description!), dismissButton: .default(Text("Dismiss")))
                }
            
            List {
                ForEach(invoiceDetails.Documents, id: \.DocumentId) { document in
                    NavigationLink(destination: WorkflowDocument(invoiceDetails: invoiceDetails)) {
                        HStack {
                            Text("\(document.Name!).\(document.Extension!)")
                        }
                    }
                }
            }
            .padding(.top, 10)
            .frame(width: nil, height: 100, alignment: .leading)
            
            List {
                ForEach(invoiceDetails.TextAnnotations?.sorted(by: { $0.Created ?? Date() > $1.Created ?? Date() }) ?? [], id: \.Id) { annotation in
                    Log(annotation: annotation)
                }
            }
            .padding(.top, 10)
            
            Button("Take Action  \(Image(systemName: "paperplane"))", action: {
                self.getActionNames(invoiceId: invoice.DocumentId)
            })
                .buttonStyle(ThemedButtonStyle(backgroundColor: .primaryColor))
                .foregroundColor(.white)
            
            Button("Add Comment  \(Image(systemName: "text.bubble"))", action: {
                self.showCommentBox.toggle()
            })
                .buttonStyle(ThemedButtonStyle(backgroundColor: .secondary))
                .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                
            NavigationLink(destination: WorkflowDocument(invoiceDetails: invoiceDetails, formData: true)) {
                HStack {
                    Text("View Form Data  \(Image(systemName: "doc.text"))")
                        .frame(width: 180)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .textCase(.uppercase)
                        .font(.system(size: 16, weight: .bold))
                        .background(Color.secondary)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                        .cornerRadius(4)
                }
            }
            .disabled(invoiceDetails.FormNameList == nil)
        }.onAppear(perform: {
            self.getInvoiceDetails(invoiceId: invoice.DocumentId)
        })
            .partialSheet(isPresented: $showCommentBox) {
                VStack {
                    Text("Enter Comment")
                    TextEditor(text: $comment)
                        .textFieldStyle(FormFieldStyle())
                        .padding()
                        .border(envColor(colorScheme), width: 1)
                    Button("Add") {
                        self.addComment(documentId: invoiceDetails.DocumentId, comment: comment)
                    }
                    .buttonStyle(ThemedButtonStyle(backgroundColor: .primaryColor))
                    .foregroundColor(Color.white)
                }.padding()
                    .frame(height: 250)
            }
            .navigationBarTitle(invoice.OrderNumber ?? "", displayMode: .inline)
    }
}

struct InvoiceDetail_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceDetail(invoice: Mocks.invoice).environmentObject(Mocks.userAuth)
    }
}
