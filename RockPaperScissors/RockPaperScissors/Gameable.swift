//
//  Game.swift
//  RockPaperScissors
//
//  Created by 민다훈 on 2023/05/04.
//

protocol Gameable {
    var turn: Player { get set }
    var matchResult: Result { get set }
    
    func generateComputerRandomNumber() -> Int
    func printResult()
}

extension Gameable {
    func generateComputerRandomNumber() -> Int {
        return Int.random(in: 1...3)
    }
}
