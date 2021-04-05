import Foundation
import Moya

struct BellatrixAccessTokenPlugin: PluginType {
    var defaults = UserDefaults.standard
    var bellatrixToken = "BellatrixToken"

    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request

        if let accessToken = defaults.string(forKey: bellatrixToken) {
            request.addValue(accessToken, forHTTPHeaderField: bellatrixToken)
            return request
        }
        return request
    }
}
