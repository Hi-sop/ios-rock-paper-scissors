//
//  RockPaperScissors - main.swift
//  Created by Hisop, 쥬봉이
//  Copyright © yagom academy. All rights reserved.
// 

enum Winner: String {
    case user = "사용자"
    case computer = "컴퓨터"
}

enum RockPaperScissors: String, CaseIterable {
    case rock
    case paper
    case scissors
}

func playRockPaperScissorsGame() {
    print("가위(1), 바위(2), 보(3)! <종료 : 0> : ", terminator: "")
    
    let userInput = readLine()
    
    guard userInput != "0" else {
        print("게임 종료")
        return
    }
    
    guard let userChoice = mappingUserChoice(userInput: userInput, round: 1) else {
        print("잘못된 입력입니다. 다시 시도해주세요.")
        playRockPaperScissorsGame()
        return
    }
    
    guard let winner = decideVictory(userChoice: userChoice) else {
        print("비겼습니다!")
        playRockPaperScissorsGame()
        return
    }
    
    if winner == .user {
        print("이겼습니다!")
    } else {
        print("졌습니다!")
    }
    playMukchippaGame(winner: winner)
}

func playMukchippaGame(winner: Winner?) {
    guard let turn = winner else {
        return
    }
    print("[\(turn.rawValue) 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : ", terminator: "")

    let userInput = readLine()
    
    guard userInput != "0" else {
        print("게임 종료")
        return
    }
    
    guard let userChoice = mappingUserChoice(userInput: userInput, round: 2) else {
        print("잘못된 입력입니다. 다시 시도해주세요.")
        playMukchippaGame(winner: .computer)
        return
    }
    
    guard let winner = decideVictory(userChoice: userChoice) else {
        print("\(turn.rawValue)의 승리!")
        return
    }
    print("\(winner.rawValue)의 턴입니다.")
    
    playMukchippaGame(winner: winner)
}


func mappingUserChoice(userInput: String?, round: Int) -> RockPaperScissors?  {
    if round == 1 {
        switch userInput {
        case "1":
            return .scissors
        case "2":
            return .rock
        case "3":
            return .paper
        default:
            return nil
        }
    } else {
        switch userInput {
        case "1":
            return .rock
        case "2":
            return .scissors
        case "3":
            return .paper
        default:
            return nil
        }
    }
}

func decideVictory(userChoice: RockPaperScissors) -> Winner? {
    let computerChoice = RockPaperScissors.allCases.randomElement()
    
    guard computerChoice != userChoice else {
        return nil
    }
    
    guard (computerChoice == .scissors && userChoice == .paper) ||
            (computerChoice == .rock && userChoice == .scissors) ||
            (computerChoice == .paper && userChoice == .rock) else {
        return .user
    }
    
    return .computer
}

playRockPaperScissorsGame()
