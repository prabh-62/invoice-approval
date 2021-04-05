import PDFKit
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    var downloadedFile = DownloadedFile()
    
    public typealias UIViewControllerType = UIActivityViewController
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let document = PDFDocument(data: downloadedFile.data)
        var metadata = document?.documentAttributes
        metadata?[PDFDocumentAttribute.authorAttribute] = "Apple"
        metadata?[PDFDocumentAttribute.titleAttribute] = downloadedFile.fileName
        document?.documentAttributes = metadata
        
        let dataRepresentation = document?.dataRepresentation() ?? Data()
        let controller = UIActivityViewController(activityItems: [dataRepresentation],
                                                  applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
