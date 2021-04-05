struct Invoice: Codable, Hashable {
    var DocumentId: String = ""
    var CustomerName: String?
    var OrderNumber: String?
    var Date: String?
    var Workflow: String?
    var StringDate: String?
}

struct Invoices: Codable {
    var WorkFlows: [Invoice]
}
