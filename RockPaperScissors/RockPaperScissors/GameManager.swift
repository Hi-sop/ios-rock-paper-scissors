//
//  RockPaperScissors - GameManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

struct GameManager {
    
    func startRockPaperScissorsGame() {
        guard let userHandShape = receiveHandShapeFromUser() else {
            print(ManualMessage.ending)
            return
        }
        let gameResult = fetchGameResult(of: userHandShape)
        
        switch gameResult {
        case .win:
            print(GameResultMessage.winning)
            return
        case .lose:
            print(GameResultMessage.losing)
            return
        case .draw:
            print(GameResultMessage.draw)
            startRockPaperScissorsGame()
        }
    }
    
    private func receiveHandShapeFromUser() -> HandShape? {
        let userHandShapeRawValue = receiveHandShapeRawValueFromUser()
        
        if userHandShapeRawValue == 0 {
            return nil
        }
        return HandShape.init(rawValue: userHandShapeRawValue)
    }
    
    private func receiveHandShapeRawValueFromUser() -> Int {
        print(ManualMessage.userInputManual, terminator: "")
        guard let input = readLine(),
              let HandShapeRawValue = Int(input),
              HandShapeRawValue >= 0,
              HandShapeRawValue <= 3 else {
            print(ErrorMessage.invalidHandShapeRawValue)
            return receiveHandShapeRawValueFromUser()
        }
        
        return HandShapeRawValue
    }
    
    private func fetchGameResult(of userHandShape: HandShape) -> GameResult {
        let computerHandShape = generateComputerHandShape()
        let rawValueDifference = computerHandShape.rawValue - userHandShape.rawValue
        
        if rawValueDifference == 0 {
            return .draw
        } else if rawValueDifference == -1 || rawValueDifference == 2 {
            return .win
        } else {
            return .lose
        }
    }
    
    private func generateComputerHandShape() -> HandShape {
        guard let computerHandShape = HandShape.init(rawValue: Int.random(in: 1...3)) else { return generateComputerHandShape() }
        return computerHandShape
    }
}
