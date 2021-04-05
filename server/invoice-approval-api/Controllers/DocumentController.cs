using System.IO;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApprovalApi.Controllers
{
    [ApiController]
    public class DocumentController : ControllerBase
    {

        [HttpGet("api/GetDocumentStream")]
        public IActionResult GetDocumentStream(string documentId, string extension = "pdf")
        {
            var fileName = $"{documentId}.pdf";
            var filePath = Path.GetFullPath("Documents/BOL.pdf");
            return PDFFile(fileName, filePath);
        }

        [HttpGet("api/GetFormDataStream")]
        public IActionResult GetFormDataPdfStream(string documentId, string formNames)
        {
            var fileName = $"{documentId}_{formNames}.pdf";
            var filePath = Path.GetFullPath("Documents/Remittance_Sheet.pdf");
            return PDFFile(fileName, filePath);
        }

        private PhysicalFileResult PDFFile(string fileName, string filePath)
        {
            HttpContext.Response.Headers["Access-Control-Expose-Headers"] = "Content-Disposition";
            return PhysicalFile(filePath, "application/pdf", fileName);
        }
    }
}
