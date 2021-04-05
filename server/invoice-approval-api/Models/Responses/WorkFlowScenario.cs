using System;

namespace InvoiceApprovalApi.Models.Responses
{
    public class WorkFlowBaseData
    {
        public string DocumentId { get; set; }
        public string CustomerName { get; set; }
        public string OrderNumber { get; set; }
        public DateTime? Date { get; set; }
        public string Workflow { get; set; }
        public string StringDate => Date.HasValue ? Date.Value.ToString("yyyy-MM-dd") : "";
    }

    public class WorkFlowDetails
    {
        public string DocumentId { get; set; }
        public string Invoice { get; set; }
        public string Vendor { get; set; }
        public DateTime? Date { get; set; }
        public string StringDate => Date.HasValue ? Date.Value.ToString("yyyy-MM-dd") : "";
        public double? InvoiceAmount { get; set; }
        public string CostCenter { get; set; }
        public string Workflow { get; set; }
        public double? PurchaseAmount { get; set; }
        public int In_RecStamp { get; set; }
        public ElectronicFormNameList FormNameList { get; set; }
        public DocumentTextAnnotation[] TextAnnotations { get; set; }
        public DocumentBasicInfo[] Documents { get; set; }
        public Approver[] Approvers { get; set; }
    }

    public class WorkFlowScenarioQueue
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string SourceQueue { get; set; }
        public string[] DestinationQueue { get; set; } = Array.Empty<string>();
        public WorkFlowQuestion[] Questions { get; set; } = Array.Empty<WorkFlowQuestion>();
    }

    public class WorkFlowQuestion
    {
        public string Question { get; set; }
        public string QuestionType { get; set; }
        public string[] Answers { get; set; } = Array.Empty<string>();
    }
}
