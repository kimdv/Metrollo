//
//  BrightFire.swift
//  Metrollo
//
//  Created by Kim de Vos on 14/03/2019.
//  Copyright © 2019 Kim de Vos. All rights reserved.
//

import Alamofire
import Promises

public func request(_ endpoint: Endpoint) -> Promise<(Data, HTTPURLResponse?)> {
    let promise: Promise<(Data, HTTPURLResponse?)>
    
    if endpoint.useMock {
        promise = Promise(on: DispatchQueue.main, { () -> (Data, HTTPURLResponse?) in
            return (endpoint.mockData, nil)
        })
        .delay(endpoint.mockDelay)
    } else if let url = endpoint.fullUrl {
        promise = Alamofire.request(url,
                                    method: endpoint.method,
                                    parameters: endpoint.parameters,
                                    headers: endpoint.headers)
            .responseData()
    } else {
        promise = Promise.init(BFError.invalidUrl)
    }
    
    return promise
}

public func request<T: Decodable>(_ endpoint: Endpoint) -> Promise<T> {
    return request(endpoint)
        .then { $0.0 }
        .decodeJson(dateDecodingStrategy: endpoint.dateDecodingStrategy)
}
