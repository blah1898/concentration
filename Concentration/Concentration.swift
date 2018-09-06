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
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard : Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func selectCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.selectCard(at: \(index)): chosen index not in the cards")
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
            } else {
                // Update index of the only selected card
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init (numberOfPairsOfCards pairCount: Int) {
        assert(pairCount > 0, "Concentration.init(pairCount: \(pairCount)): you must add at least a pair of cards")
        for _ in 1...pairCount {
            // Generate a pair of cards and append it to the cards array.
            // We don't need to copy the card, since it's a struct and is passed by
            // value.
            let card = Card()
            cards += [card, card]
        }
    }
}
    
