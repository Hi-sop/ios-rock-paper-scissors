//
//  RockPaperScissors - HandSign.swift
//  Created by 혜모리, 무리 on 2022.12.27
//

enum HandSign: Int {
    case scissor, rock, paper
     
    static func convertHandSignType(_ number: Int, gameType: HandSignGameType) -> HandSign? {
        if gameType == HandSignGameType.rockPaperScissors {
            switch number {
            case 1:
                return .scissor
            case 2:
                return .rock
            case 3:
                return .paper
            default:
                return nil
            }
        } else {
            switch number {
            case 1:
                return .rock
            case 2:
                return .scissor
            case 3:
                return .paper
            default:
                return nil
            }
        }
    }
}

