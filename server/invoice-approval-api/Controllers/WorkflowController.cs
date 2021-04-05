using System;
using System.Collections.Generic;
using System.Linq;
using InvoiceApprovalApi.Models;
using InvoiceApprovalApi.Models.Requests;
using InvoiceApprovalApi.Models.Responses;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApprovalApi.Controllers
{
    public class FeedbackForDocument
    {
        public string DocumentId { get; set; }
        public DateTime DateTime { get; set; }
        public string Log { get; set; }
    }

    [ApiController]
    public class WorkflowController : ControllerBase
    {
        private static readonly List<FeedbackForDocument> logCollection = new()
        {
            new FeedbackForDocument
            {
                DocumentId = "DOC4312",
                Log = "Reviewed it",
                DateTime = DateTime.Now.Date
            },
            new FeedbackForDocument
            {
                DocumentId = "DOC4312",
                Log = "Approving it for now",
                DateTime = DateTime.Now.Date
            }
        };


        [HttpGet("api/GetWorkflowActionNames")]
        public IActionResult GetWorkflowActionNames()
        {
            return Ok(new WorkflowActionNamesResponse
            {
                ActionNames = new string[] { "Approve", "Approve above the limit", "Wrong Approver or Cost Centre", "Reject" },
                ApLogic = "Logic2"
            });
        }

        [HttpGet("api/SearchWorkflows")]
        public IActionResult SearchWorkflows(string? vendorName, string? invoiceNumber, int? documentLimit = 10)
        {
            var appleTrucking = new WorkFlowBaseData
            {
                DocumentId = "DOC4312",
                CustomerName = "Apple Trucking",
                OrderNumber = "O6492",
                Date = DateTime.Now,
                Workflow = "Approval"
            };
            var m1Trucking = new WorkFlowBaseData
            {
                DocumentId = "DOC6298",
                CustomerName = "M1 Transport",
                OrderNumber = "O8392",
                Date = DateTime.Now,
                Workflow = "Approval"
            };
            var m2Trucking = new WorkFlowBaseData
            {
                DocumentId = "DOC8570",
                CustomerName = "M2 Transport",
                OrderNumber = "O8479",
                Date = DateTime.Now,
                Workflow = "Approval"
            };
            var response = new SearchWorkflowsResponse
            {
                WorkFlows = new WorkFlowBaseData[] { appleTrucking, m1Trucking, m2Trucking }
            };

            return Ok(response);
        }

        [HttpGet("api/GetWorkflowDetails")]
        public IActionResult GetWorkflowDetails(string documentId)
        {
            var random = new Random();

            var workflowDetails = new WorkFlowDetails
            {
                DocumentId = documentId,
                Invoice = "INV3982348",
                Vendor = "Apple Inc",
                Date = DateTime.Now.Date,
                InvoiceAmount = 11288.0 + random.NextDouble(),
                CostCenter = "Sales Dep",
                Workflow = "Approval",
                PurchaseAmount = 11000.0 + random.NextDouble(),
                In_RecStamp = 12,
                FormNameList = new ElectronicFormNameList
                {
                    formNamesField = new string[] { "Remittance_Sheet" }
                },
                TextAnnotations = logCollection
                        .Where(log => string.Equals(log.DocumentId, documentId, StringComparison.OrdinalIgnoreCase))
                        .Select(log => new DocumentTextAnnotation
                        {
                            Id = random.Next(1, 10000),
                            Created = log.DateTime,
                            Creator = "Domain/User",
                            Text = log.Log
                        }
                ).ToArray(),
                Documents = new DocumentBasicInfo[]{
                    new DocumentBasicInfo{
                        DocumentId = "DOC4312",
                        Name = "INV823923",
                        DocumentType = "BOL",
                        Extension = "tif",
                        }
                },
                Approvers = new Approver[]{
                    new Approver{
                        DisplayName = "Approver",
                        Limit = "15000",
                        UserName = "Domain/secondUser"
                        }
                }
            };
            return Ok(new WorkflowDetailsResponse
            {
                WorkFlowDetails = workflowDetails
            });
        }

        [HttpPost("api/PostFeedback")]
        public IActionResult PostFeedback(string documentId, [FromBody] FeedbackModel model)
        {
            var date = DateTime.Now;
            date = new DateTime(date.Year, date.Month, date.Day, date.Hour, date.Minute, date.Second, date.Kind);

            logCollection.Add(new FeedbackForDocument
            {
                DocumentId = documentId,
                Log = model.Feedback,
                DateTime = date
            });
            return Ok(new PostFeedbackResponse
            {
                IsSubmitted = true
            });
        }
    }
}
