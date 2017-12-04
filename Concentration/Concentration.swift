//
//  Concentration.swift
//  Concentration
//
//  Created by Margaret Scott on 12/3/17.
//  Copyright © 2017 eudaimonious. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()

    var indexOfOneAndOnlyFaceUpCard: Int?

    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    init(numberOfPairsOfCards: Int) {
        Card.resetIdentifierFactory()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }

        var shuffled = [Card]()

        for _ in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffled.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }

        cards = shuffled
    }
}
