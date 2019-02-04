//
//  common.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 03/02/2019.
//  Copyright © 2019 Dmitry Dementyev. All rights reserved.
//

import Foundation
func IntInf(_ s: String) -> Int {
    return (s == K.infSymbol) ? Int.max : Int(s)!
}
