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
    
    /**
    Shuffle the elements of an array using Fisher-Yates
     
    - parameters:
      - array : The array to shuffle
     
    - returns: The new shuffled array
     */
    static func shuffle<T>(array a: Array<T>) -> Array<T> {
        // Copy the array in a mutable form
        var shuffled = a;
        
        // The algorithm we're running will swap the current element with one of the
        // elements that go after it (Fisher-Yates Algorithm)
        
        // We go up to shuffled.count - 2, because if we go up to shuffled.count - 1,
        // the last element will be swapped with itself, an unnecesary step.
        for i in 1..<(shuffled.count - 1) {
            let swapPosition = Int(arc4random_uniform(UInt32(shuffled.count - i - 1))) + i
            shuffled.swapAt(i, swapPosition)
        }
        
        return shuffled
    }
    
    func reset() {
        // Unmatch all cards and place them face down
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
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
    
