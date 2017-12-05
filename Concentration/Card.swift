//
//  Card.swift
//  Concentration
//
//  Created by Margaret Scott on 12/3/17.
//  Copyright © 2017 eudaimonious. All rights reserved.
//

import Foundation

struct Card : Hashable
{
    var hashValue: Int { return identifier }

    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    var isFaceUp = false
    var isMatched = false
    var seenAtLeastOnce = false
    private var identifier: Int

    private static var identifierFactory = 0

    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    static func resetIdentifierFactory() {
        identifierFactory = 0
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
