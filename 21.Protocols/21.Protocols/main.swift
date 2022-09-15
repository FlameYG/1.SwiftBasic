//
//  main.swift
//  21.Protocols
//
//  Created by yonggeun Kim on 2022/09/15.
//

/* 예제1 : 프로퍼티 */
//protocol FullyNamed {
//    var fullName: String { get }
//}
//
//struct Person: FullyNamed {
//    var fullName: String
//}
//
//class Starship: FullyNamed {
//    var prefix: String?
//    var name: String
//    init(name: String, prefix: String? = nil) {
//        self.name = name
//        self.prefix = prefix
//    }
//    var fullName: String {
//        return (prefix != nil ? prefix! + " " : "") + name
//    }
//}
//var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
//print(ncc1701.fullName)

/* 예제2 : 메서드 */
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
//let generator = LinearCongruentialGenerator()
//print("Here's a random number: \(generator.random())")
//// Prints "Here's a random number: 0.3746499199817101"
//print("And another one: \(generator.random())")
//// Prints "And another one: 0.729023776863283"

/* 예제3 : 메서드 변경 */
//protocol Togglable {
//    mutating func toggle()
//}
//
//enum OnOffSwitch: Togglable {
//    case off, on
//    mutating func toggle() {
//        switch self {
//        case .off:
//            self = .on
//        case .on:
//            self = .off
//        }
//    }
//}
//var lightSwitch = OnOffSwitch.off
//lightSwitch.toggle()
//// lightSwitch is now equal to .on

/* 예제4 : 타입으로 프로토콜 - 예제2와 함께 사용 */
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
//
//var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
//for _ in 1...5 {
//    print("Random dice roll is \(d6.roll())")
//}

/* 예제5 : 위임 */
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
