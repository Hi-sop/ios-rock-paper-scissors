//
//  RockPaperScissors - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

enum Winner: String {
    case user = "사용자"
    case computer = "컴퓨터"
    case none
}

//enum RockPaperScissors: String {
//    case scissors = "1"
//    case rock = "2"
//    case paper = "3"
//}

//@discardableResult
func startGame(winner: Winner) {
    guard winner == .none else {
        playSecondGame(turn: winner)
        return
    }

    print("가위(1), 바위(2), 보(3)! <종료 : 0> : ", terminator: "")

    guard let userChoice = readLine() else {
        print("잘못된 입력입니다. 다시 시도해주세요.")
        startGame(winner: .none)
        return
    }

    switch userChoice {
    case "1", "2", "3":
        startGame(winner: decidePrintMessage(userChoice: userChoice, winner: winner))
    case "0":
        print("게임 종료")
        return
    default:
        print("잘못된 입력입니다. 다시 시도해주세요.")
        startGame(winner: .none)
    }
}

func decidePrintMessage(userChoice: String, winner: Winner) -> Winner {
    let winPrint: String = "이겼습니다."
    let losePrint: String = "졌습니다."
    
    switch winner {
    case .none:
        let drawPrint: String = "비겼습니다."
        let victory: Winner = decideVictory(userChoice: userChoice, drawPrint: drawPrint, firstPrint: losePrint, secondPrint: winPrint)
        return victory
    case .user, .computer:
        let drawPrint: String = "\(winner.rawValue)의 승리!"
        let victory: Winner = decideVictory(userChoice: userChoice, drawPrint: drawPrint, firstPrint: winPrint, secondPrint: losePrint)
        return victory
    }
}

func decideVictory(userChoice: String, drawPrint: String, firstPrint: String, secondPrint: String) -> Winner {
    let computerChoice: String = String(Int.random(in: 1...3))
    
    print(computerChoice)
    
    guard computerChoice != userChoice else {
        print(drawPrint)
        return .none
    }

    guard (computerChoice == "1" && userChoice == "2") ||
            (computerChoice == "2" && userChoice == "3") ||
            (computerChoice == "3" && userChoice == "1") else {
        print(firstPrint)
        return firstPrint == "이겼습니다." ? .user : .computer
    }

    print(secondPrint)
    return secondPrint == "이겼습니다." ? .user: .computer
}

//@discardableResult
func playSecondGame(turn: Winner) {
    guard turn != .none else {
        return
    }

    print("[\(turn.rawValue) 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : ", terminator: "")

    guard let userChoice = readLine() else {
        print("잘못된 입력입니다. 다시 시도해주세요.")
        playSecondGame(turn: .computer)
        return
    }

    switch userChoice {
    case "1", "2", "3":
        playSecondGame(turn: decidePrintMessage(userChoice: userChoice, winner: turn))
    case "0":
        print("게임 종료")
        return
    default:
        print("잘못된 입력입니다. 다시 시도해주세요.")
        playSecondGame(turn: .computer)
    }
}

startGame(winner: .none)
