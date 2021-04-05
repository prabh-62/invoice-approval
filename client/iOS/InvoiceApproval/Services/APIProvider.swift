import Foundation
import Moya
import SwiftUI

let authPlugin = BellatrixAccessTokenPlugin()
let correlationTokenPlugin = CorrelationTokenPlugin()
let cachePlugin = MoyaCacheablePlugin()
let networkLoggerPlugin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))

let provider = MoyaProvider<MiddleTier>(plugins: [
    cachePlugin,
    networkLoggerPlugin,
    authPlugin,
    correlationTokenPlugin,
])

public enum MiddleTier {
    case login(LoginCredentials)
    case logOut
    case invoices
    case invoiceDetails(invoiceId: String)
    case downloadInvoiceDocument(documentId: String)
    case downloadRemittanceSheet(invoiceId: String, formNames: [String])
    case addComment(documentId: String, comment: DocumentComment)
    
    case actionNames(invoiceId: String)
}

extension MiddleTier: TargetType {
    public var baseURL: URL {
        return URL(string: "http://localhost:5000/api")!
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/login"
        case .logOut:
            return "/logout"
        case .invoices:
            return "/SearchWorkflows"
        case .invoiceDetails:
            return "/GetWorkflowDetails"
        case .downloadInvoiceDocument:
            return "/GetDocumentStream"
        case .downloadRemittanceSheet:
            return "/GetFormDataStream"
        case .addComment:
            return "/PostFeedback"
        case .actionNames:
            return "/GetWorkflowActionNames"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login, .addComment:
            return .post
        case .logOut, .invoices, .invoiceDetails, .downloadInvoiceDocument, .downloadRemittanceSheet,
             .actionNames:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .login, .logOut, .invoices, .invoiceDetails, .downloadInvoiceDocument, .downloadRemittanceSheet, .addComment, .actionNames:
            return "{\"login\": \"\", \"id\": 100}".data(using: String.Encoding.utf8)!
        }
    }
    
    public var task: Task {
        switch self {
        case .login(let credentials):
            return .requestJSONEncodable(credentials)
        case .logOut, .invoices:
            return .requestPlain
        case .invoiceDetails(let invoiceId):
            return .requestParameters(parameters: ["documentId": invoiceId], encoding: URLEncoding.default)
        case .downloadInvoiceDocument(let documentId):
            return .requestParameters(parameters: ["documentId": documentId, "extension": "pdf"], encoding: URLEncoding.default)
        case .downloadRemittanceSheet(let documentId, let formNames):
            return .requestParameters(parameters: ["documentId": documentId, "FormNames": formNames.joined(separator: ",")], encoding: URLEncoding.default)
        case .addComment(let documentId, let comment):
            return .requestCompositeParameters(bodyParameters: ["Feedback": comment.feedback], bodyEncoding: JSONEncoding.default, urlParameters: ["documentId": documentId])
        case .actionNames(let invoiceId):
            return .requestParameters(parameters: ["invoiceId": invoiceId], encoding: URLEncoding.default)
        }
    }
    
    public var validationType: ValidationType {
        switch self {
        case .login, .logOut, .invoices, .invoiceDetails, .downloadInvoiceDocument, .downloadRemittanceSheet, .addComment, .actionNames:
            return .none
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

extension MiddleTier: MoyaCacheable {
    //    Cache
    var cachePolicy: MoyaCacheablePolicy {
        switch self {
        case .invoices,
             .downloadInvoiceDocument,
             .downloadRemittanceSheet,
             .actionNames:
            return .returnCacheDataElseLoad
        default:
            return .reloadIgnoringLocalAndRemoteCacheData
        }
    }
}

enum MappingError: Error {
    case emptyBody
    case serverError(message: String)
}

public func mapTo<T: Codable>(_ result: Result<Moya.Response, MoyaError>) throws -> T {
    let response = try result.get()
    let contentLength = Int(response.response?.value(forHTTPHeaderField: "Content-Length") ?? "0") ?? 0
    if contentLength <= 0 {
        print("Zero Content-Length")
//        throw MappingError.emptyBody
    }
    if response.statusCode >= 500 {
        let errorMessage = String(data: response.data, encoding: String.Encoding.utf8)!
        throw MappingError.serverError(message: errorMessage)
    }
    
    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .iso8601
    
    if response.statusCode >= 400 {
        let baseResponse = try jsonDecoder.decode(DocumentResponseError.self, from: response.data)
        throw MappingError.serverError(message: baseResponse.Message)
    }
    if response.statusCode != 200 {
        throw MappingError.serverError(message: "Server Error")
    }
    
    if let contentDispostion = response.response?.value(forHTTPHeaderField: "Content-Disposition") {
        let fileName = String(contentDispostion.split(separator: "=")[1].split(separator: ";")[0])
        return DownloadedFile(data: response.data, fileName: fileName) as! T
    }
    
    let baseResponse = try jsonDecoder.decode(ResponseBase.self, from: response.data)
    if baseResponse.ResponseStatus == .Error {
        throw MappingError.serverError(message: baseResponse.ErrorMessage!)
    }
    
    let mappedObject = try jsonDecoder.decode(T.self, from: response.data)
    return mappedObject
}

public func getErrorObject(_ error: Error) -> ErrorDescription {
    switch error {
    case MappingError.emptyBody:
        return ErrorDescription(title: "Error", description: "An error occured")
    case MappingError.serverError(let message):
        return ErrorDescription(title: "Error", description: message)
    default:
        return ErrorDescription(title: "Error", description: error.localizedDescription)
    }
}
