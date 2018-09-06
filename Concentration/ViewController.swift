//
//  ViewController.swift
//  Concentration
//
//  Created by comp05A on 8/15/18.
//  Copyright © 2018 Universidad Autonoma de Baja California. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    private var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let index = cardButtons.index(of: sender) {
            game.selectCard(at: index)
            flipCount += 1
        } else {
            fatalError("Button not found")
        }
        updateViewFromModel()
    }
    
    private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    private var selectedEmoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {

        if selectedEmoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = 3.arc4random
            selectedEmoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return selectedEmoji[card.identifier] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) :#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
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

