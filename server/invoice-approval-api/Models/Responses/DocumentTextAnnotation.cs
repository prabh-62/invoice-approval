using System;

namespace InvoiceApprovalApi.Models
{
    public class DocumentTextAnnotation : ResponseBase
    {
        public int Id { get; set; }
        public DateTime Created { get; set; }
        public string Creator { get; set; }
        public string Text { get; set; }
    }
}
