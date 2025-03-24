//
//  charIdentity.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//

import Foundation

enum ExpressionHelper {
    
//    static func isDelimiter(_ symbol: String) -> Bool {
//        return " =".contains(symbol)
//    }

    static func isOperator(_ symbol: Character) -> Bool {
        return "+-÷×()".contains(symbol)
    }

    static func getPriority(_ symbol: String) -> Int {
        switch symbol {
        case "(":
            return 0
        case ")":
            return 1
        case "+", "-":
            return 2
        case "×", "÷":
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
}

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

