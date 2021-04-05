namespace InvoiceApprovalApi.Models.Responses
{
    public class SearchWorkflowsResponse : ResponseBase
    {
        public WorkFlowBaseData[] WorkFlows { get; set; }
    }
}
