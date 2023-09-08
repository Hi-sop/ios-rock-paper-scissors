//
//  RockPaperScissors - main.swift
//  Created by Hisop, 쥬봉이
//  Copyright © yagom academy. All rights reserved.
// 

enum PrintOptions {
    case roundStart
    case roundWin
    case draw
    case gameWin
    case gameEnd
    case invalidInput
}

enum Winner: String {
    case user = "사용자"
    case computer = "컴퓨터"
}

enum RockPaperScissors: CaseIterable {
    case rock
    case paper
    case scissors
}

func playRockPaperScissorsGame() {
    displayRoundOneResult(printOption: .roundStart)
    
    let userInput = readLine()
    
    guard userInput != "0" else {
        displayRoundOneResult(printOption: .gameEnd)
        return
    }
    
    guard let userChoice = mappingUserChoice(userInput: userInput, round: 1) else {
        displayRoundOneResult(printOption: .invalidInput)
        playRockPaperScissorsGame()
        return
    }
    
    guard let winner = decideVictory(userChoice: userChoice) else {
        displayRoundOneResult(printOption: .draw)
        playRockPaperScissorsGame()
        return
    }
    displayRoundOneResult(printOption: .roundWin, winner: winner)
    
    playMukchippaGame(winner: winner)
}

func displayRoundOneResult(printOption: PrintOptions, winner: Winner? = nil) {
    switch printOption {
    case .roundStart:
        print("가위(1), 바위(2), 보(3)! <종료 : 0> : ", terminator: "")
        return
    case .roundWin:
        if winner == .user {
            print("이겼습니다!")
        } else {
            print("졌습니다!")
        }
    case .draw:
        print("비겼습니다!")
    case .invalidInput:
        print("잘못된 입력입니다. 다시 시도해주세요.")
    case .gameEnd:
        print("게임 종료")
    default:
        break
    }
}

func playMukchippaGame(winner: Winner?) {
    guard let turn = winner else {
        return
    }
    displayRoundTwoResult(printOption: .roundStart, winner: turn)
    
    let userInput = readLine()
    
    guard userInput != "0" else {
        displayRoundTwoResult(printOption: .gameEnd, winner: turn)
        return
    }
    
    guard let userChoice = mappingUserChoice(userInput: userInput, round: 2) else {
        displayRoundTwoResult(printOption: .invalidInput, winner: turn)
        playMukchippaGame(winner: .computer)
        return
    }
    
    guard let roundWinner = decideVictory(userChoice: userChoice) else {
        displayRoundTwoResult(printOption: .gameWin, winner: turn)
        return
    }
    displayRoundTwoResult(printOption: .roundWin, winner: roundWinner)
    
    playMukchippaGame(winner: roundWinner)
}

func displayRoundTwoResult(printOption: PrintOptions, winner: Winner) {
    switch printOption {
    case .roundStart:
        print("[\(winner.rawValue) 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : ", terminator: "")
    case .roundWin:
        print("\(winner.rawValue)의 턴입니다.")
    case .gameWin:
        print("\(winner.rawValue)의 승리!")
    case .invalidInput:
        print("잘못된 입력입니다. 다시 시도해주세요.")
    case .gameEnd:
        print("게임 종료")
    default:
        break
    }
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
