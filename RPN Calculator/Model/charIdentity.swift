//
//  charIdentity.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//

import Foundation

enum ExpressionHelper {
    
    static func isOperator(_ symbol: Character) -> Bool {
        return allOperators.contains(symbol)
    }

    static func getPriority(_ symbol: String) -> Int {
        switch symbol {
        case Op.leftParenthesis.rawValue:
            return 0
        case Op.rightParenthesis.rawValue:
            return 1
        case Op.addition.rawValue, Op.subtraction.rawValue:
            return 2
        case Op.multiplication.rawValue, Op.division.rawValue:
            return 3
        default:
            return 4
        }
    }
}

enum Op: String {
    case addition = "+"
    case subtraction = "-"
    case multiplication = "×"
    case division = "÷"
    case leftParenthesis = "("
    case rightParenthesis = ")"
    case eraseAll = "A"
    case deleteLast = "⌫"
    case equalSign = "="
    case decimal = "."
    case zero = "0"
    case e = "e"
}

let allOperators = "+-÷×()"

let arithmeticOperators: [String] = [Op.addition.rawValue, Op.subtraction.rawValue, Op.multiplication.rawValue, Op.division.rawValue]

func areParenthesesBalanced(in expression: String) -> Bool {
    var count = 0
    for char in expression {
        if String(char) == Op.leftParenthesis.rawValue {
            count += 1
        } else if String(char) == Op.rightParenthesis.rawValue {
            count -= 1
        }
        if count < 0 { return false }
    }
    return count == 0
}

var didCalculate: Bool = false

func isResultInvalid(_ expression: String) -> Bool {
    let lowercased = expression.lowercased()
    return lowercased == "nan" || lowercased == "inf" || lowercased == "-inf"
}

func disableOperLeftParenthesis(_ expression: String) -> Bool {
    if expression.count >= 2 {
        let preLastIndex = expression.index(expression.endIndex, offsetBy: -2)
        let preLastChar = expression[preLastIndex]
        if let last = expression.last, Op.subtraction.rawValue == String(last) {
            if String(preLastChar) == Op.leftParenthesis.rawValue{
                return true
            }
        }
    }
    return false
}

let buttonCharacters = [
    ["A","(",")","÷"],
    ["7","8","9","×"],
    ["4","5","6","-"],
    ["1","2","3","+"],
    ["⌫", "0",".", "="]
]

