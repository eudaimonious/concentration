//
//  Concentration.swift
//  Concentration
//
//  Created by Margaret Scott on 12/3/17.
//  Copyright © 2017 eudaimonious. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0

    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): you must have at least one pair of cards")
        Card.resetIdentifierFactory()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }

        var shuffled = [Card]()

        for _ in cards.indices {
            let randomIndex = cards.count.arc4random
            shuffled.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }

        cards = shuffled
    }

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    private mutating func markPairAsSeen(forCardIndex index: Int) {
        let pairIndices = cards.indices.filter { cards[$0] == cards[index] }
        pairIndices.forEach { cards[$0].seenAtLeastOnce = true }
    }

    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    [matchIndex, index].forEach { cards[$0].isMatched = true; score += 1}
                } else {
                    [matchIndex, index].forEach { penalizeMismatch(forCardIndex: $0) }
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    mutating func penalizeMismatch(forCardIndex index: Int) {
        if cards[index].seenAtLeastOnce {
            score -= 1
        } else {
            markPairAsSeen(forCardIndex: index)
        }
    }

}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
