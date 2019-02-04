//
//  wordCard.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 04/02/2019.
//  Copyright © 2019 Dmitry Dementyev. All rights reserved.
//

import Foundation

class WordCard {
    var text: String
    var color: WordColor
    var guessed: Bool
    init(text: String, color: WordColor) {
        self.text = text
        self.color = color
        self.guessed = false
    }
}
