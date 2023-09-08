## 묵찌빠 게임
``첫번째 가위,바위,보 게임``으로 승패를 결정합니다. 승자는 두번째 게임에서 첫 주도권을 잡게 됩니다.
``두번째 묵찌빠 게임``에서는 가위,바위,보와 동일한 방식으로 진행되며, 승자에게 턴이 넘겨집니다. 같은 패를 낼 경우 해당 턴을 쥐고 있는 쪽이 게임의 최종 승자가 됩니다.

---
### 목차
- [팀원](#팀원)
- [타임라인](#타임라인)
- [시각화 구조](#시각화-구조)
- [실행 화면](#실행-화면)
- [트러블 슈팅](#트러블-슈팅)
- [참고 링크](#참고-링크)
- [팀 회고](#팀-회고)

---
### 팀원
|Hisop🐨|쥬봉이🐱|
|---|---|
|[GitHub](https://github.com/Hi-sop)|[GitHub](https://github.com/jyubong)|

### 타임라인
|날짜|내용|
|------|---|
|23.09.04|공식문서 공부, 순서도 작성, 코딩 컨벤션 논의|
|23.09.05|가위바위보 게임 구현, 첫번째 PR|
|23.09.07|가위바위보 게임 수정, 묵찌빠 게임 구현, 두번째 PR|
|23.09.08|Naming 수정, ReadMe 업데이트|

### 시각화 구조
<img src="https://github.com/Hi-sop/ios-rock-paper-scissors/assets/126065608/6b09f5b9-8274-4d57-a819-0860db342af9" width="300">    
    
   
### 실행 화면
|게임종료|가위바위보 게임|
|---|---|
|![](https://hackmd.io/_uploads/SknZTVOC3.gif)|![](https://hackmd.io/_uploads/BkaXpNuR3.gif)|

|묵찌빠 게임|최종 승리|
|---|---|
|![](https://hackmd.io/_uploads/B10rpEdR3.gif)|![](https://hackmd.io/_uploads/SkBwaE_Cn.gif)|

|잘못 입력(가위바위보)|잘못 입력(묵찌빠)|
|---|---|
|![잘못입력1](https://github.com/Hi-sop/ios-rock-paper-scissors/assets/69287436/91381efa-2b8a-42ca-8871-74fb1b4caa35)|![잘못입력2](https://github.com/Hi-sop/ios-rock-paper-scissors/assets/69287436/a6c6fe76-7a13-4449-a8a1-4dffcd9549f6)|

   
### 트러블 슈팅

#### 1. 순환함수에서 재귀함수로 변경
   프로그램이 비교적 빠른 성능을 요구하지 않으며 코드의 가독성을 올리기 위해 변경하기로 결정했습니다.

**이전 코드(while문)**
``` swift
func startGame() {
    var isPlaying: Bool = true

    while isPlaying {
        print("가위(1), 바위(2), 보(3)! <종료 : 0> : ", terminator: "")

        guard let userChoice = readLine() else {
            print("잘못된 입력입니다. 다시 시도해주세요.")
            continue
        }

        switch userChoice {
        case "1", "2", "3":
            isPlaying = makeResult(userChoice: userChoice)
        case "0":
            print("게임 종료")
            return
        default:
            print("잘못된 입력입니다. 다시 시도해주세요.")
        }
    }
}
```
**수정 코드(재귀 함수)**
``` swift
func playRockPaperScissorsGame(progress: GameProgress) {
    guard progress != .userWin, progress != .computerWin else {
        var winner = progress
        
        displayResult(progress: progress)
        playMukchippaGame(progress: progress, turn: &winner)
        return
    }
    
    displayResult(progress: progress)
    
    let userInput = readLine()
    
    guard userInput != "0" else {
        print("게임 종료")
        return
    }
    
    guard let userChoice = mappingUserChoice(userInput: userInput, round: 1) else {
        playRockPaperScissorsGame(progress: .invalidInput)
        return
    }
    
    playRockPaperScissorsGame(progress: decideVictory(userChoice: userChoice))
}
```

#### 2. userInput을 게임에 따라 enum case 변경
``가위바위보 게임(가위 1, 바위 2)에서 묵찌빠 게임(묵 1, 찌2)로 변경``되어 userInput 따른 case가 변화되었습니다. 이를 효과적으로 구현하기 위해 mapping해주는 함수를 따로 만들어 게임에 따라 enum값이 다르게 도출되도록 하였습니다.

**코드**
```swift
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
```

#### 3. 이전 게임의 승자를 구분하는 방법
- 묵찌빠의 최종 승자를 결정하기 위해서는 이전 가위바위보 결과에 따른 승자를 구분할 필요가 있었습니다.
- 이전 코드에서는 묵찌빠게임을 호출할 때 inout변수를 전달하여 이 값을 승자에 따라 변경해주어 구분할 수 있게 했습니다.
- 이를 수정하여 winner에 이전 승자가 담기고 roundWinner에 새로운 승자를 할당하여, roundWinner가 .none일때(비긴 경우) "winner의 승리"로 출력되도록 하였습니다.

**이전 코드**
``` swift
func playMukchippaGame(progress: GameProgress, turn: inout GameProgress) {
    guard progress != .draw else {
        displayResult(progress: progress, turn: turn)
        return
    }
    
    if progress == .userWin || progress == .computerWin {
        turn = progress
    }
    
    displayResult(progress: progress, turn: turn)
    
// (코드생략)       
    
}
```

**수정 코드**
``` swift
func playMukchippaGame(winner: Winner) {
// (생략)
    
    let roundWinner = decideVictory(userChoice: userChoice)
    
    guard roundWinner != .none else {
        displayMukchippaGame(printOption: .gameWin, winner: winner)
        return
    }
    
    displayMukchippaGame(printOption: .roundWin, winner: roundWinner)
    playMukchippaGame(winner: roundWinner)
}

func decideVictory(userChoice: RockPaperScissors) -> Winner {
    let computerChoice = RockPaperScissors.allCases.randomElement()
    
    guard computerChoice != userChoice else {
        return .none
    }
    
    guard (computerChoice == .scissors && userChoice == .paper) ||
            (computerChoice == .rock && userChoice == .scissors) ||
            (computerChoice == .paper && userChoice == .rock) else {
        return .user
    }
    
    return .computer
}

func displayMukchippaGame(printOption: PrintOptions, winner: Winner) {
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
```

### 참고 링크
[Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)   
[Swift Language Guide - Control Flow](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow)   
[Swift Language Guide - Functions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions)   
[Swift Language Guide - Enumerations](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/)   
[Swift Language Guide - The Basics - Optionals](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Optionals)

---
### 팀 회고
<details>
<summary>우리팀이 잘한 점</summary>

게임 실행, 유저입력 매핑, 승패 구분, 결과 출력 등 ``최대한 기능을 분리하여 함수를 구현``하려고 했습니다.
Optional 안전하게 처리, 재귀함수, 함수 기능 분리, 깃 커밋단위 적용 등 ``프로젝트 핵심 경험``을 바탕으로 코드를 구성하려고 했습니다.
</details>

<details>
<summary>우리팀이 개선할 점</summary>

Naming이 미숙하여 여러번 수정하였습니다. API guidelines를 반복해서 읽고 연구를 해야할 것 같습니다.
main에 모든 로직을 구현하였는데, class나 struct를 사용하여 구현해보아도 좋았을 것 같습니다.
</details>

<details>
<summary>서로에게 피드백</summary>

- Hisop : 저는 머리속의 생각을 코드로 일단 적고 설명하는 느낌이 강했는데 이런 스타일도 잘 이해해주시고 코드 컨벤션 등 여러 선택하는 과정에서 저를 배려해주는 느낌이 커서 너무 좋았습니다. 고집을 좀 더 부려주세요!
- 쥬봉이 : Hisop은 하나를 구현할 때에도 여러가지 방법으로 시도를 해보았는데 이 점을 본받아야겠다고 생각했습니다. 이번 프로젝트도 그러한 결과의 산물이었습니다. 그리고 공식 문서 등 기초를 먼저 탄탄히 하고 프로젝트를 시작하는 것 또한 좋았고 대단했습니다. 제가 잘 따라지 못했음에도 불구하고 그런 점들은 자세히 다시 설명해주어서 감사합니다.
</details>
