//
//  Error.swift
//  Metrollo
//
//  Created by Kim de Vos on 15/03/2019.
//  Copyright © 2019 Kim de Vos. All rights reserved.
//

import Foundation

public enum MError: Error {
    case invalidUrl
}

public enum MMockError: Error {
    case noMockData
}
