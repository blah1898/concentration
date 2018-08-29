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
    var alreadyFlippedIndices = [Int]()
    var indexOfOneAndOnlyFaceUpCard : Int? = nil
    
    /**
    Select a card and flip it

     - parameters:
        - at : The index of the card to flip
     
     - returns : A tuple containing the following values:
        - True if the card was already flipped AND is not the currently flipped one, false otherwise
        - True if a match was made, false otherwise
    **/
    func selectCard(at index: Int) -> (Bool, Bool) {
        var alreadyFlipped = false
        var match = false
        // Only do stuff on unmatched cards
        if !cards[index].isMatched {
            // Check if we already have one face up card
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard {
                // Check if we've already flipped this card
                if alreadyFlippedIndices.contains(index) {
                    alreadyFlipped = true;
                } else {
                    alreadyFlippedIndices += [index]
                }
                // Check for match
                if cards[matchedIndex].identifier == cards[index].identifier {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                    match = true
                }
                // Turn the selected card faceup. Since we don't have just one card up,
                // set the index of the only face card up to nil
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else if indexOfOneAndOnlyFaceUpCard != index {
                // Check if we've already flipped this card
                if alreadyFlippedIndices.contains(index) {
                    alreadyFlipped = true;
                } else {
                    alreadyFlippedIndices += [index]
                }
                
                // Either 0 or 2 cards are face up, flip everything back down
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                
                // Flip the selected card and update index of the only selected card
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        return (alreadyFlipped, match)
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
        cards = Concentration.shuffle(array: cards)
    }
    
    init (numberOfPairsOfCards pairCount: Int) {
        for _ in 1...pairCount {
            // Generate a pair of cards and append it to the cards array.
            // We don't need to copy the card, since it's a struct and is passed by
            // value.
            let card = Card()
            cards += [card, card]
        }
        cards = Concentration.shuffle(array: cards)
    }
}
    
