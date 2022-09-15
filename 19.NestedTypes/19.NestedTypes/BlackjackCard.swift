//
//  BlackjackCard.swift
//  19.NestedTypes
//
//  Created by Dragon on 2022/09/06.
//

struct BlackjackCard {
    // nested Suit enumeration
    // struct 안에 enum이 들어갈 수 있습니다.
    enum Suit: Character {
        case spades = "♠"
        case hearts = "♡"
        case diamonds = "♢"
        case clubs = "♣"
    }
    
    // nested Rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values { // enum안에 struct가 들어가는 것도 가능합니다.
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}
