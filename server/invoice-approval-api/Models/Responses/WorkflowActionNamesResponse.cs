using System;

namespace InvoiceApprovalApi.Models.Responses
{
    public class WorkflowActionNamesResponse : ResponseBase
    {
        public string[] ActionNames { get; set; } = Array.Empty<string>();
        public string ApLogic { get; set; }
    }
}
