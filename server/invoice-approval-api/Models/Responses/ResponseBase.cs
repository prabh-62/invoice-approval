namespace InvoiceApprovalApi.Models
{
    public class ResponseBase
    {
        public ResponseStatus ResponseStatus { get; set; } = ResponseStatus.Success;
        public string ErrorMessage { get; set; } = "";
    }
}
