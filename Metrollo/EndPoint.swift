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
    public var useMock: Bool {
        return false
    }

    /// Default implmentaion of `mockData`. Default value is `nil`.
    public var mockData: Data? {
        return nil
    }

    /// Default implementation of `dateDecodingStrategy`. Default is `deferredToDate`
    public var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        return .deferredToDate
    }

    /// Default implementaion of `mockDelay`. Default is `0`
    public var mockDelay: TimeInterval {
        return 0
    }
}

extension Endpoint {
    var fullUrl: URL? {
        var url = URL(string: baseUrl)

        url?.appendPathComponent(path)
        return url
    }
}
