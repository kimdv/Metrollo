//
//  BrightFire.swift
//  Metrollo
//
//  Created by Kim de Vos on 14/03/2019.
//  Copyright © 2019 Kim de Vos. All rights reserved.
//

import Alamofire

public func request(_ endpoint: Endpoint) -> Promise<(Data, HTTPURLResponse?)> {
    let promise: Promise<(Data, HTTPURLResponse?)>
    
    if endpoint.useMock {
        if let data = endpoint.mockData {
            promise = Promise(on: DispatchQueue.main, { () -> (Data, HTTPURLResponse?) in
                return (data, nil)
            }).delay(endpoint.mockDelay)
        } else {
            promise = Promise(MMockError.noMockData)
        }
    } else if let url = endpoint.fullUrl {
        promise = Alamofire.request(url,
                                    method: endpoint.method,
                                    parameters: endpoint.parameters,
                                    encoding: endpoint.encoding,
                                    headers: endpoint.headers)
            .validate()
            .responseData()
    } else {
        promise = Promise.init(MError.invalidUrl)
    }
    
    return promise
}

public func request<T: Decodable>(_ endpoint: Endpoint) -> Promise<T> {
    return request(endpoint)
        .then { $0.0 }
        .decodeJson(dateDecodingStrategy: endpoint.dateDecodingStrategy)
}

public func request<T: Decodable>(_ endpoint: Endpoint) -> Promise<(T, HTTPURLResponse?)> {
    return request(endpoint)
        .then { data, response -> (T, HTTPURLResponse?) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = endpoint.dateDecodingStrategy
            return (try decoder.decode(T.self, from: data), response)
        }
}
