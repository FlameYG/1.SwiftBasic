//
//  Nourish.swift
//  17.ErrorHandling
//
//  Created by yonggeun Kim on 2022/08/31.
//

//func nourish(with item: String) throws {
//    do {
//        try vendingMachine.vend(itemNamed: item)
//    } catch is VendingMachineError {
//        print("Couldn't buy that from the vending machine.")
//    }
//}

//func eat(item: String) throws {
//    do {
//        try vendingMachine.vend(itemNamed: item)
//    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
//        print("Invalid selection, out of stock, or not enough money.")
//    }
//}

//do {
//    try nourish(with: "Beet-Flavored Chips")
//} catch {
//    print("Unexpected non-vending-machine-related error: \(error)")
//}
//// Prints "Couldn't buy that from the vending machine."
