//
//  ViewController.swift
//  Concentration
//
//  Created by Margaret Scott on 12/3/17.
//  Copyright © 2017 eudaimonious. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!

    private let emojiThemes = [
        ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨"], // animals
        ["🎅", "🤶", "🦌", "☃️", "🎄", "🎁", "🧦", "🔔", "🕯️"], // christmas
        ["🤮", "🙄", "🤯", "🤩", "🤪", "🤨", "🤠", "🤬", "🤤"], // faces
        ["🍕", "🍔", "🍣", "🌮", "🍿", "🍗", "🥐", "🥑", "🌽"], // food
        ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"], // halloween
        ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓"], // sports
    ]

    private let labelStyling: [NSAttributedStringKey:Any] = [
        .strokeWidth: 5.0,
        .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    ]

    private var emoji = [Card:String]()
    private var emojiChoices: [String] = []
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    override func viewDidLoad() {
        updateLabels()
        updateTheme()
    }

    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }

    @IBAction private func touchNewGame() {
        emoji = [Card:String]()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateTheme()
        updateViewFromModel()
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }

    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }

        return emoji[card] ?? "?"
    }

    private func updateLabels() {
        flipCountLabel.attributedText = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: labelStyling)
        scoreLabel.attributedText = NSAttributedString(string: "Score: \(game.score)", attributes: labelStyling)
    }

    private func updateTheme() {
        emojiChoices = emojiThemes[emojiThemes.count.arc4random]
    }

    private func updateViewFromModel() {
        updateLabels()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

