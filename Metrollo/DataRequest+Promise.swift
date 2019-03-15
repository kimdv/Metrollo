//
//  DataRequest+Promise.swift
//  Metrollo
//
//  Created by Kim de Vos on 14/03/2019.
//  Copyright © 2019 Kim de Vos. All rights reserved.
//

import Alamofire
import Promises

extension DataRequest {
    func responseData() -> Promise<(Data, HTTPURLResponse?)> {
        return Promise(on: .global(qos: .background)) { fullfill, reject in
            self.responseData(completionHandler: { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    fullfill((data, dataResponse.response))
                case .failure(let error):
                    reject(error)
                }
            })
        }
    }
}
