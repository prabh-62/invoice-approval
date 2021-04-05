import PDFKit
import SwiftUI

struct RemotePDF: UIViewRepresentable {
    var downloadedFile: DownloadedFile
    
    func makeUIView(context: Context) -> some PDFView {
        let document = PDFDocument(data: downloadedFile.data)
        var metadata = document?.documentAttributes
        metadata?[PDFDocumentAttribute.authorAttribute] = "Apple"
        metadata?[PDFDocumentAttribute.titleAttribute] = downloadedFile.fileName
        document?.documentAttributes = metadata
        
        let pdfView = PDFView()
        pdfView.document = document
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.document = PDFDocument(data: downloadedFile.data)
    }
}

struct RemotePDF_Previews: PreviewProvider {
    static var previews: some View {
        RemotePDF(downloadedFile: DownloadedFile())
    }
}
