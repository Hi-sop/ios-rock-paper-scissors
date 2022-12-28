//  RockPaperScissors - MookZziBba.swift
//  Created by vetto, songjun on 2022.12.28.

import Foundation

func printTurnAndMenu(winner: Winner) {
    print("[\(winner)턴] 묵(1), 찌(2), 빠(3)! <종료: 0> :", terminator: " ")
}

func inputUserNumber2() -> Int {
    guard let userInput = readLine() else {
        return inputUserNumber2()
    }
    guard let userNumber = Int(userInput) else {
        print("잘못된 입력입니다. 다시 시도해주세요.")
        return inputUserNumber2()
    }
    return userNumber
}

func decideMZBWinner(turn: Winner,
                     _ userHand: MookZizBba,
                     _ computerHand: MookZizBba) -> (Winner, Turn) {
    switch (turn, userHand, computerHand) {
    case (.user, .mook, .mook), (.user, .zzi, .zzi), (.user, .bba, .bba):
        return (.user, .userTurn)
    case (.computer, .mook, .mook), (.computer, .zzi, .zzi), (.computer, .bba, .bba):
        return (.computer, .computerTurn)
    case (.user, .mook, .zzi), (.user, .zzi, .bba), (.user, .bba, .mook):
        return (.draw, .userTurn)
    case (.computer, .mook, .zzi), (.computer, .zzi, .bba), (.computer, .bba, .mook):
        return (.draw, .computerTurn)
    case (.user, .zzi, .mook), (.user, .bba, .zzi), (.user, .mook, .bba):
        return (.draw, .computerTurn)
    default:
        return (.draw, .userTurn)
    }
}

