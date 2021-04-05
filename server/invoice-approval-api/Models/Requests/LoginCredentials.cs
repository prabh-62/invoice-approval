namespace InvoiceApprovalApi.Models.Requests
{
    public class LoginCredentials
    {
        public string UserName { get; set; }
        public string Password { get; set; }
        public string DeviceToken { get; set; }
    }
}
