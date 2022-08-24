//
//  step1.swift
//  RockPaperScissors
//
//  Created by Victor on 2022/08/23.
//

import Foundation

enum RockScissorsPaper: Int {
    case 가위 = 1
    case 바위 = 2
    case 보 = 3
}

enum MukChiBba: Int {
    case 묵 = 1
    case 찌 = 2
    case 빠 = 3
}

func filterUserInput() -> Int? {
    if let input = readLine(),
       let userNumber = Int(input.replacingOccurrences(of: " ", with: "")),
       0...3 ~= userNumber {
        return userNumber
    }
    print("잘못된 입력입니다. 다시 시도해주세요.")
    return nil
}

func readyRockScissorsPaperGame() {
    var computerNumber: Int
    var exitGame: Bool = false

    while exitGame == false {
        computerNumber = Int.random(in: 1...3)

        print("가위(1), 바위(2), 보(3)! <종료 : 0> :", terminator: " ")

        guard let userNumber = filterUserInput() else {
            print("잘못된 입력입니다. 다시 시도해주세요.")
            continue
        }

        exitGame = startRockScissorsPaperGame(by : computerNumber, and : userNumber)
    }
}

func startRockScissorsPaperGame(by computerChoice: Int, and userChoice: Int) -> Bool {
    var userWin: Bool
    let selectMenu = userChoice
    let computerPick = RockScissorsPaper(rawValue: computerChoice)
    let userPick = RockScissorsPaper(rawValue: userChoice)
    let compareTwoThings = (컴퓨터가낸것: computerPick, 유저가낸것: userPick)
    
    if selectMenu == 0 {
        print("게임 종료")
        return true
    } else if computerPick == userPick {
        print("비겼습니다!")
        return false
    }
    
    switch compareTwoThings {
    case (컴퓨터가낸것: .가위, 유저가낸것: .바위),
        (컴퓨터가낸것: .바위, 유저가낸것: .보),
        (컴퓨터가낸것: .보, 유저가낸것: .가위):
        print("이겼습니다!")
        userWin = true
        readyMukChiBbaGame(takeUserWin: userWin)
        return true
    default:
        print("졌습니다!")
        userWin = false
        readyMukChiBbaGame(takeUserWin: userWin)
        return true
    }
}

func readyMukChiBbaGame(takeUserWin: Bool) {
    var exit: Bool = false
    var takeUserWin = takeUserWin
    var computerNumber: Int
    var roundOneWinner: String {
        get {
            if takeUserWin == true {
                return "사용자"
            } else {
                return "컴퓨터" }
        }
    }
    
    while exit == false {
        computerNumber = Int.random(in: 1...3)
        print("[\(roundOneWinner) 턴] (묵(1), 찌(2), 빠(3)! <종료 : 0> : ", terminator: "")
        
        guard let userNumber = filterUserInput() else {
            if takeUserWin == true {
                takeUserWin = !takeUserWin
            }
            continue
        }
        
        var exitOrTurnChange = (나가기: exit, 유저이겼나체크: takeUserWin)
        exitOrTurnChange = startMukChiBbaGame(computerNumber: computerNumber, userNumber: userNumber, takeUserWin: takeUserWin)
        
        switch exitOrTurnChange {
        case (true, _):
            exit = true
        case (false, false):
            takeUserWin = false
            continue
        case (false, true):
            takeUserWin = true
            continue
        }
    }
}

func startMukChiBbaGame(computerNumber: Int, userNumber: Int, takeUserWin: Bool) -> (Bool,Bool) {
    var takeUserWin = takeUserWin
    let computerPick = MukChiBba(rawValue: computerNumber)
    let userPick = MukChiBba(rawValue: userNumber)
    let compareTwoThings = (컴퓨터가낸것: computerPick, 유저가낸것: userPick)
    
    if userNumber == 0 {
        print("게임 종료")
        return (true,takeUserWin)
    } else if computerPick == userPick && takeUserWin == true {
        print("사용자의 승리!")
        return (true,takeUserWin)
    } else if computerPick == userPick && takeUserWin == false {
        print("컴퓨터의 승리!")
        return (true,takeUserWin)
    }
    
    switch compareTwoThings {
    case (컴퓨터가낸것: .묵, 유저가낸것: .빠),
        (컴퓨터가낸것: .찌, 유저가낸것: .묵),
        (컴퓨터가낸것: .빠, 유저가낸것: .찌):
        takeUserWin = true
    default:
        takeUserWin = false
    }
    return (false,takeUserWin)
}
