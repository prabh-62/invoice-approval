import Foundation

struct WorkflowDetails: Codable {
    var DocumentId = ""
    var Invoice: String?
    var Vendor: String?
    var Date: Date?
    var InvoiceAmount: Double?
    var CostCenter: String?
    var Workflow: String?
    var PurchaseAmount: Double?
    var In_RecStamp: Int?
    var FormNameList: ElectronicFormNameList?
    var TextAnnotations: [DocumentLog]?
    var Documents = [DocumentBasicInfo]()
    var Approvers = [Approver]()
}

struct InvoiceDetails: Codable {
    var WorkFlowDetails: WorkflowDetails
}
