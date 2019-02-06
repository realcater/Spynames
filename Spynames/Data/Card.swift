//
//  wordCard.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 04/02/2019.
//  Copyright © 2019 Dmitry Dementyev. All rights reserved.
//

import Foundation

class Card {
    var word: String
    var color: CardColor
    var guessed: Bool
    init(text: String, color: CardColor) {
        self.word = text
        self.color = color
        self.guessed = false
    }
}
// Добавить положение, отобразить так, сяк...
//Это сделать в визуальном объекте UICard
