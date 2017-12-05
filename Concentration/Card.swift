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
    private static var identifierFactory = 0

    var isFaceUp = false
    var isMatched = false
    var seenAtLeastOnce = false
    private var identifier: Int

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }

    var hashValue: Int { return identifier }

    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    static func resetIdentifierFactory() {
        identifierFactory = 0
    }

    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}
