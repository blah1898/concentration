//
//  ViewController.swift
//  Concentration
//
//  Created by comp05A on 8/15/18.
//  Copyright © 2018 Universidad Autonoma de Baja California. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*
     |--------------------------------------------------------------------------------------------------
     | TODO
     |--------------------------------------------------------------------------------------------------
     | 1. Add more cards
     | 2. Add a "New Game" button, that will restart the game
     | 3. Shuffle the cards in the in Concentration's init()
     | 4. Add themes to the game. At least 6 themes. One must be chosen at random on startup.
     | 5. Make adding a theme as simple as adding a single line of code
     | 6. Add a score counting label. 2 points per match, -1 point per mismatch if flipped previously.
     | 7. Move the amount of card flips to the Model (to properly follow MVC)
     | 8. Ensure the UI looks good in an iPhone X in portrait
     |
     |--------------------------------------------------------------------------------------------------
     | Extra Credit
     |--------------------------------------------------------------------------------------------------
     | A. Change the background color and color of the back of the cards to match the theme.
     | B. Make the player gain extra points for working fast.
     |
     */

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let index = cardButtons.index(of: sender) {
            game.selectCard(at: index)
            flipCount += 1
        } else {
            fatalError("Button not found")
        }
        updateViewFromModel()
    }
    
    var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🧟‍♂️"]
    	
    var selectedEmoji = [Int: String]()
    
    func emoji(for card: Card) -> String {

        if selectedEmoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            selectedEmoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return selectedEmoji[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
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

