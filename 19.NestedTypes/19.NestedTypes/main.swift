//
//  main.swift
//  19.NestedTypes
//
//  Created by Dragon on 2022/09/06.
//

let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
print(heartsSymbol)

let test = BlackjackCard.init(rank: .ace, suit: .clubs).description
print(test)
