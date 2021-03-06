//
//  EndPoint.swift
//  Metrollo
//
//  Created by Kim de Vos on 14/03/2019.
//  Copyright © 2019 Kim de Vos. All rights reserved.
//

public protocol Endpoint {

    /// Base URL for the target
    var baseUrl: String { get }

    /// Path for the target
    var path: String { get }

    /// Method used for the target
    var method: HTTPMethod { get }

    /// Parameters used for the target
    var parameters: Parameters { get }

    /// Headers for the target
    var headers: HTTPHeaders { get }

    /// Define how a set of parameters are applied.
    var encoding: ParameterEncoding { get }

    /// Date decoding strategy for the target. Default is `deferredToDate`
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }

    /// Mock data that is used when `useMock` is `true`.
    var mockData: Data? { get }

    /// Use mock or not. Default is false
    var useMock: Bool { get }

    /// Delay used when mocking. Specified in seconds.
    ///
    /// Default is 0.
    var mockDelay: TimeInterval { get }
}

public extension Endpoint {

    /// Default implmentaion of `useMock`. Default is `false`.
    var useMock: Bool {
        return false
    }

    /// Default implmentaion of `mockData`. Default value is `nil`.
    var mockData: Data? {
        return nil
    }

    /// Default implementation of `dateDecodingStrategy`. Default is `deferredToDate`
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        return .deferredToDate
    }

    /// Default implementation of `encoding`. Default value is `URLEncoding.default` from Alamofire.
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    /// Default implementaion of `mockDelay`. Default is `0`
    var mockDelay: TimeInterval {
        return 0
    }
}

public extension Endpoint {
    /// Returns the full URL path for the endpoint.
    var fullURL: URL? {
        var url = URL(string: baseUrl)

        url?.appendPathComponent(path)
        return url
    }
}
