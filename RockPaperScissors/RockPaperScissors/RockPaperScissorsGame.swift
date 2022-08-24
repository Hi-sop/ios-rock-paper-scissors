class RockPaperScissorsGame {
    var RPSWinner = ""
    
    func startRPSGame() {
        printMenu()
        
        guard let userNumber = fetchUserNumber() else {
            print("잘못된 입력입니다. 다시 시도해주세요.")
            return startRPSGame()
        }
        
        if userNumber == 0 {
            print("게임종료")
            return
        }
        
        let computerRPSNumber = Int.random(in: 1...3)
        
        guard let userRPS = convertRPS(from: userNumber),
              let computerRPS = convertRPS(from: computerRPSNumber) else {
            print("잘못된 입력입니다. 다시 시도해주세요.")
            return startRPSGame()
        }
        
        let gameResult = judgeUserGameResultIn(userRPS, computerRPS)
        
        printResult(of: gameResult)
        
        switch gameResult {
        case .win:
            RPSWinner = "유저"
            return
        case .lose:
            RPSWinner = "컴퓨터"
            return
        case .draw:
            startRPSGame()
        }
    }
    
    func printMenu() {
        print("가위(1), 바위(2), 보(3)! <종료 : 0> :", terminator: " ")
    }
    
    func fetchUserNumber() -> Int? {
        guard let userInput = readLine() else {
            return nil
        }
        
        return Int(userInput)
    }
    
    func convertRPS(from input: Int) -> RPS? {
        return RPS(rawValue: input)
    }

    func judgeUserGameResultIn(_ userRPS: RPS, _ computerRPS: RPS ) -> GameResult {
        switch (userRPS, computerRPS) {
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            return .win
        case (.rock, .paper), (.scissors, .rock), (.paper, .scissors):
            return .lose
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            return .draw
        }
    }
    
    func printResult(of result: GameResult) {
        switch result {
        case .win:
            print("이겼습니다!")
        case .lose:
            print("졌습니다!")
        case .draw:
            print("비겼습니다!")
        }
    }
}
