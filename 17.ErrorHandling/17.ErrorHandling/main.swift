//
//  main.swift
//  17.ErrorHandling
//
//  Created by Dragon on 2022/08/31.
//

/* 1.던지기함수(기본예제) */
//let testInit1 = VendingMachine()
//testInit1.coinsDeposited = 5
//let snack = try PurchasedSnack(name: "Pretzels", vendingMachine: testInit1)

//정상출력 - Coin:20, CandyBar Price:12, RemainedCoin:8
//testInit1.coinsDeposited = 20
//let test: () = try testInit1.vend(itemNamed: "Candy Bar")
//print(testInit1.coinsDeposited)

//에러출력(VendingMachineError.invalidSelection) - "3" NotSetting
//let test: () = try testInit1.vend(itemNamed: "4")
//print(testInit1.coinsDeposited)

//에러출력(VendingMachineError.outOfStock) - "Pretzels" outOfStock
//testInit1.coinsDeposited = 100
//for _ in 1...12 {
//    let test: () = try testInit1.vend(itemNamed: "Pretzels")
//}
//print(testInit1.coinsDeposited)

//에러출력(VendingMachineError.insufficientFunds) - Coin:0, CandyBar Price:12, RemainedCoin:0
//let test: () = try testInit1.vend(itemNamed: "Candy Bar")
//print(testInit1.coinsDeposited)


// 2.Do-Catch사용(기본예제)
let testInit2 = VendingMachine()

//정상출력 - Coin:20, "Alice"-Chips Price:10, RemainedCoin:10
//testInit2.coinsDeposited = 20
//print("Success! Yum.")

//에러출력1 Coin:8, "Alice"-Chips Price:10, RemainedCoin:구매불가
//testInit2.coinsDeposited = 8
//print("Insufficient funds. Please insert an additional 2 coins.")

//에러출력2 Coin:100, "Alice"-Chips Price:10, Repeat:10, RemainedCoin:60, RemainedStock:0
testInit2.coinsDeposited = 100
//print("Out of Stock.")

// Do-Try-Catch문 - "Alice"고정
for _ in 1...10 { // 에러출력2에서 사용
    do {
        try buyFavoriteSnack(person: "Alice", vendingMachine: testInit2)
        print("Success! Yum.")
    } catch VendingMachineError.invalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.outOfStock {
        print("Out of Stock.")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    } catch {
        print("Unexpected error: \(error).")
    }
} // 에러출력2에서 사용


/* 3.옵셔널값사용(그냥 만들어본 예제 - 공식문서 예제가 이해가 안되서 간단하게 만들어봄) */
//enum PrinterError: Error {
//    case outOfPaper
//    case noToner
//    case onFire
//}
//
//func send(job: Int, toPrinter printerName: String) throws -> String {
//    if printerName == "Never Has Toner" {
//        throw PrinterError.noToner
//    }
//    return "Job sent"
//}
//
//let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
//print(printerSuccess!)
////let printerSuccess = try! send(job: 1884, toPrinter: "Mergenthaler")
////print(printerSuccess)
//
//let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
//print(printerFailure!)
////let printerFailure = try! send(job: 1885, toPrinter: "Never Has Toner")
////print(printerFailure)
