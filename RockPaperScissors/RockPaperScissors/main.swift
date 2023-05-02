//
//  RockPaperScissors - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

enum RockPaperScissors: Int {
    case scissors = 1
    case rock = 2
    case paper = 3
}

func compareRockPaperScissors(between computerRockPaperScissors: RockPaperScissors, and playerRockPaperScissors: RockPaperScissors) -> String {
    
    if computerRockPaperScissors == playerRockPaperScissors {
        return "비겼습니다!"
    }

    switch playerRockPaperScissors {
    case .scissors:
        return computerRockPaperScissors == RockPaperScissors.paper ? "이겼습니다!" : "졌습니다!"
    case .rock:
        return computerRockPaperScissors == RockPaperScissors.scissors ? "이겼습니다!" : "졌습니다!"
    case .paper:
        return computerRockPaperScissors == RockPaperScissors.rock ? "이겼습니다!" : "졌습니다!"
    }
}

func getUserInput() -> Bool {
    var isGameInProgress: Bool = true
    
    print("가위(1), 바위(2), 보(3)! <종료 : 0> :", terminator: " ")
    guard let input = readLine() else { return isGameInProgress }

    switch input {
    case "1", "2", "3":
        guard let inputNumber = Int(input),
              let playerRockPaperScissors = RockPaperScissors(rawValue: inputNumber),
              let computerRockPaperScissors = RockPaperScissors(rawValue: Int.random(in: 1...3)) else {
            return isGameInProgress
        }
        print(compareRockPaperScissors(between: computerRockPaperScissors, and: playerRockPaperScissors))
    case "0":
        isGameInProgress = false
        print("게임 종료")
    default:
        print("잘못된 입력입니다. 다시 시도해주세요.")
    }
    return isGameInProgress
}

func startGame() {
    var isGameInProgress: Bool = true
    
    repeat {
        isGameInProgress = getUserInput()
    } while isGameInProgress
}

startGame()
