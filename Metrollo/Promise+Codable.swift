//
//  Promise+Codable.swift
//  Metrollo
//
//  Created by Kim de Vos on 14/03/2019.
//  Copyright © 2019 Kim de Vos. All rights reserved.
//

import Alamofire
import Promises

extension Promise  {
    func decodeJson<T: Decodable>(data: Data,
                                  dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) -> Promise<T> {
        return Promise<T>(on: .global(qos: .background), { () -> T in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = dateDecodingStrategy
            return try decoder.decode(T.self, from: data)
        })
    }
}

extension Promise where Value == Data {
    func decodeJson<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) -> Promise<T> {
        return then { data in
            return self.decodeJson(data: data, dateDecodingStrategy: dateDecodingStrategy)
        }
    }
}
