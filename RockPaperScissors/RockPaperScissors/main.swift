//
//  RockPaperScissors - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

enum Choice: String {
    case scissors = "1"
    case rock = "2"
    case paper = "3"
}

enum Winner: String {
    case user = "사용자"
    case computer = "컴퓨터"
}

@discardableResult
func startGame(continueRecursive: Bool) -> Bool {
    guard continueRecursive else {
    return false
    }

    print("가위(1), 바위(2), 보(3)! <종료 : 0> : ", terminator: "")

    guard let userChoice = readLine() else {
        print("잘못된 입력입니다. 다시 시도해주세요.")
        return startGame(continueRecursive: true)
    }

    switch userChoice {
    case "1", "2", "3":
        startGame(continueRecursive: compareWithComputer(userChoice: userChoice))
    case "0":
        print("게임 종료")
        break
    default:
        startGame(continueRecursive: true)
    }

    return false

}

func compareWithComputer(userChoice: String) -> Bool {
    let computerNumber: String = String(Int.random(in: 1...3))

    guard let computerChoice: Choice = Choice(rawValue: computerNumber),
          let userChoice: Choice = Choice(rawValue: userChoice) else {
        return true
    }

    guard computerChoice != userChoice else {
        print("비겼습니다!")
        return true
    }

    guard (computerChoice == .scissors && userChoice == .paper) ||
            (computerChoice == .rock && userChoice == .scissors) ||
            (computerChoice == .paper && userChoice == .rock) else {
        print("이겼습니다!")
        return playSecondGame(continueRecursive: true, turn: .user)
    }

    print("졌습니다!")
    return playSecondGame(continueRecursive: true, turn: .computer)

}

@discardableResult
func playSecondGame(continueRecursive: Bool, turn: Winner) -> Bool{
    guard continueRecursive else {
    return false
    }

    print("[\(turn.rawValue) 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : ", terminator: "")

    guard let userChoice = readLine() else {
        print("잘못된 입력입니다. 다시 시도해주세요.")
        return playSecondGame(continueRecursive: true, turn: .computer)
    }

    switch userChoice {
    case "1", "2", "3":
        let (bool,winner) = winOrLose(userChoice: userChoice, turn: turn)
        playSecondGame(continueRecursive: bool, turn: winner)
    case "0":
        print("게임 종료")
        break
    default:
        playSecondGame(continueRecursive: true, turn: .computer)
    }

    return false
}

func winOrLose(userChoice: String, turn: Winner) -> (Bool, Winner) {
    let computerNumber: String = String(Int.random(in: 1...3))

    guard let computerChoice: Choice = Choice(rawValue: computerNumber),
          let userChoice: Choice = Choice(rawValue: userChoice) else {
        return (true, .computer)
    }

    guard computerChoice != userChoice else {
        print("""
        같은 패입니다.
        \(turn.rawValue)의 승리!
        """)
        return (false, turn)
    }

    guard (computerChoice == .scissors && userChoice == .paper) ||
            (computerChoice == .rock && userChoice == .scissors) ||
            (computerChoice == .paper && userChoice == .rock) else {
        print("이겼습니다!")
        return (true, .user)
    }

    print("졌습니다!")
    return (true, .computer)

}

startGame(continueRecursive: true)
