//
//  Concentration.swift
//  Concentration
//
//  Created by comp05A on 8/21/18.
//  Copyright © 2018 Universidad Autonoma de Baja California. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard : Int? = nil
    
    func selectCard(at index: Int) {
        // Only do stuff on unmatched cards
        if !cards[index].isMatched {
            // Check if we already have one face up card
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                // Check for match
                if cards[matchedIndex].identifier == cards[index].identifier {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                }
                // Turn the selected card faceup. Since we don't have just one card up,
                // set the index of the only face card up to nil
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // Either 0 or 2 cards are face up, flip everything back down
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                
                // Flip the selected card and update index of the only selected card
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func reset() {
        // Unmatch all cards and place them face down
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        // TODO: shuffle the cards again
    }
    
    init (numberOfPairsOfCards pairCount: Int) {
        for _ in 1...pairCount {
            // Generate a pair of cards and append it to the cards array.
            // We don't need to copy the card, since it's a struct and is passed by
            // value.
            let card = Card()
            cards += [card, card]
        }
    }
}
    
