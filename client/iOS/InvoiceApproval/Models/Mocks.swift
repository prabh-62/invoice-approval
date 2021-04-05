import Foundation

struct Mocks {
    static var invoice = Invoice(DocumentId: "O38859", CustomerName: "M Trucking", OrderNumber: "", Date: "", Workflow: "Approval", StringDate: "")

    static var invoiceDetails = WorkflowDetails(DocumentId: "O38859", Invoice: "W9382483", Vendor: "Apple Inc", Date: Date(), InvoiceAmount: nil, CostCenter: "Sales Department", Workflow: "Approval", PurchaseAmount: 10001.0, In_RecStamp: 12, FormNameList: ElectronicFormNameList(formNamesField: ["AP_Remittance_Sheet"]), TextAnnotations: [DocumentLog(Id: 14, Created: Date(), Creator: "Domain\\User", Text: "Reviewed")], Documents: [DocumentBasicInfo(DocumentId: "O38859", Name: "INV8839", Extension: "tif", DocumentType: "BOL")], Approvers: [Approver(DisplayName: "Steve", Limit: "400", UserName: "Domain\\User")])

    static var userAuth: UserAuth {
        let auth = UserAuth()
        auth.accessToken = "2g7twrZvq2Ehw7Ww5a2R0miRvPfc1r5sVkJnS/eHCQxNnJ6ZHO7/upf28unmgSWouQXT0lr5c9Aofi/SQI60vuFu7JhrfZ8lxKkj41XvliifJ9rs0hbXNmBf3Vabt4MxbN4xaR7knz4CpZON+F7srH1cy+lMqhhNdVolGYeYPi1+f6D41B8Mb6A/jV70FJHH03YrkLfuBJuzKx+8pB1/mwmzOiKuP614qlAbyilFQDVez1WCD3mu7vU1ueh7N8OPDNGPFmJ9T6SkVPmDCCCZY+/rWN96RTkTVE37ysrDFHG3g0NEbY7ApSk1RC8iGdKFBuXl1BvEJuNUmSAM8qFWj1PI7BdVJrpgoWgrmrZAcG8cNuD5fnuaYXSFqEicz62GuGYEPR3l2eeJ1Q0r+s6026KDkpro4PtG3agVuTdzs1LwGplCEIYRwHiiCXKu42maJJtWmjQ8AdEKrgAnlVDtHdEIGUs57/pkFIxyRVaGV1/vIoVkbMG5pnhD6Q7epVC38LL5NpvpMY9bzf6TW+1bUhhBKIphwi1aDjOcj7cqxtQ7tdOZ8u+fv4ojSmk/LactRPJn3mayDQgSHDFTu5bLh0Lg4WU1gFGav7N6bCf8iMAQsQHsE/5TXjbM7FNxZ6S2u0p4m/JybN8xkKA/SrBEAx/hSGRoOxUylClm6lUYk6qSWlOXFDf/r4TJa9G/NW47OFbHgwSN/Tdc9nz/basDPlUl62t/zBPZnP+wCwuLsSnlJQXL1wyiAayXZ/hIFYi510D/EMHJp7tBXOlAL2400VNK92oTCFQ+9z7VToeAa26Ggf/951BdwaNYPvW4Z6YqEOxyJec5vuZIrPoa3G0eNWO8Kuw/N2DkDDXSros2ZU3TmLsVe+GIfYUx0jYDIU/7/vnW5CkpDnbrzARXAqFJJ0U2DAYFF7Uin9VY0Zp8fz3Ddv9JVqZqyLx9XAldvGJLBpr/JAu9eLt7oIRTzWPhnBQFajwuun9/5XfEIKVs/JM68gtXBauIsdt9PUd8muJGlEJ6DrIjmakESVlD8wj6YJB94CdQqs6QENrRwksbfSssEbLqOZx/HBianATlm4GaEqjsUbpvSl3FSX2s7DWVd2mtKPu+uLhUMpzDvVkXBimA5oIqZ7I1UKGtyrhytWPn"
        return auth
    }
}
