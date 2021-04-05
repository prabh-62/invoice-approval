import Foundation
import Moya

struct CorrelationTokenPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        let correlationToken = UUID()

        request.addValue(correlationToken.uuidString, forHTTPHeaderField: "Correlation-Token")
        return request
    }
}
