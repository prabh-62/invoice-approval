using System.Linq;
using InvoiceApprovalApi.Models;
using InvoiceApprovalApi.Models.Requests;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApprovalApi.Controllers
{
    [ApiController]
    public class LoginController : ControllerBase
    {

        [HttpPost("api/login")]
        public IActionResult Login(LoginCredentials credentials)
        {
            if (credentials == null || credentials.UserName == null || credentials.Password == null)
            {
                return BadRequest("Invalid credentials");
            }
            return Ok(new LoginResponse
            {
                BellatrixToken = "2g7twrZvq2Ehw7Ww5a2R0miRvPfc1r5sVkJnS/eHCQxNnJ6ZHO7/upf28unmgSWouQXT0lr5c9Aofi/SQI60vuFu7JhrfZ8lxKkj41XvliifJ9rs0hbXNmBf3Vabt4MxbN4xaR7knz4CpZON+F7srH1cy+lMqhhNdVolGYeYPi1+f6D41B8Mb6A/jV70FJHH03YrkLfuBJuzKx+8pB1/mwmzOiKuP614qlAbyilFQDVez1WCD3mu7vU1ueh7N8OPDNGPFmJ9T6SkVPmDCCCZY+/rWN96RTkTVE37ysrDFHG3g0NEbY7ApSk1RC8iGdKFBuXl1BvEJuNUmSAM8qFWj1PI7BdVJrpgoWgrmrZAcG8cNuD5fnuaYXSFqEicz62GuGYEPR3l2eeJ1Q0r+s6026KDkpro4PtG3agVuTdzs1LwGplCEIYRwHiiCXKu42maJJtWmjQ8AdEKrgAnlVDtHdEIGUs57/pkFIxyRVaGV1/vIoVkbMG5pnhD6Q7epVC38LL5NpvpMY9bzf6TW+1bUhhBKIphwi1aDjOcj7cqxtQ7tdOZ8u+fv4ojSmk/LactRPJn3mayDQgSHDFTu5bLh0Lg4WU1gFGav7N6bCf8iMAQsQHsE/5TXjbM7FNxZ6S2u0p4m/JybN8xkKA/SrBEAx/hSGRoOxUylClm6lUYk6qSWlOXFDf/r4TJa9G/NW47OFbHgwSN/Tdc9nz/basDPlUl62t/zBPZnP+wCwuLsSnlJQXL1wyiAayXZ/hIFYi510D/EMHJp7tBXOlAL2400VNK92oTCFQ+9z7VToeAa26Ggf/951BdwaNYPvW4Z6YqEOxyJec5vuZIrPoa3G0eNWO8Kuw/N2DkDDXSros2ZU3TmLsVe+GIfYUx0jYDIU/7/vnW5CkpDnbrzARXAqFJJ0U2DAYFF7Uin9VY0Zp8fz3Ddv9JVqZqyLx9XAldvGJLBpr/JAu9eLt7oIRTzWPhnBQFajwuun9/5XfEIKVs/JM68gtXBauIsdt9PUd8muJGlEJ6DrIjmakESVlD8wj6YJB94CdQqs6QENrRwksbfSssEbLqOZx/HBianATlm4GaEqjsUbpvSl3FSX2s7DWVd2mtKPu+uLhUMpzDvVkXBimA5oIqZ7I1UKGtyrhytWPn"
            });
        }

        [HttpGet]
        [Route("api/logout")]
        public IActionResult Logout()
        {
            string? bellatrixToken = string.Empty;
            if (Request.Headers.TryGetValue("BellatrixToken", out var headerValues))
            {
                bellatrixToken = headerValues.FirstOrDefault();
            }
            if (string.IsNullOrWhiteSpace(bellatrixToken))
            {
                return BadRequest("Access token header is missing");
            }

            return Ok(new LogoutResponse
            {
                ResponseStatus = ResponseStatus.Success,
                IsLogout = true,
            });
        }
    }
}
