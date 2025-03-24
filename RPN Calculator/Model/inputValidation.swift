//
//  inputValidation.swift
//  RPN Calculator
//
//  Created by Sukhrob Bekmuratov on 3/22/25.
//
import UIKit

protocol ExpressionHandling {
    func processOperator(_ op: String, for expression: inout String) -> String
    
    func processEqual(for expression: inout String) -> String
    
    func processDeleteLast(for expression: inout String) -> String
    
    func processEraseAll(for expression: inout String) -> String
    
    func processParenthesis(_ paren: String, for expression: inout String) -> String
    
    func processDecimal(for expression: inout String) -> String
    
    func processNumber(_ number: String, for expression: inout String) -> String
}

extension ExpressionHandling {
    
    func processOperator(_ op: String, for expression: inout String) -> String {
        
        let arithmeticOperators: [Character] = ["+","-", "×", "÷"]
        
        if let lastChar = expression.last, String(lastChar) == Op.leftParenthesis.rawValue {
            if op == Op.subtraction.rawValue {
                expression.append(op)
            }
        } else {
            if let last = expression.last, arithmeticOperators.contains(last) {
                expression.removeLast()
            }
            if expression.last == Character(Op.decimal.rawValue) {
                expression.removeLast()
            }
            expression.append(op)
        }
        return expression
    }
    
    func processEqual(for expression: inout String) -> String {
        guard var last = expression.last else {return "0"}
        
        while String(last) == Op.leftParenthesis.rawValue{
            expression.removeLast()
            last = expression.last ?? "0"
        }
        if ExpressionHelper.isOperator(last){
            expression.removeLast()
        }
        while !areParenthesesBalanced(in: expression) {
            expression.append(Op.rightParenthesis.rawValue)
        }
        print(expression)
        let rpn = RPN()
        let result = rpn.calculate(expression)
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.numberStyle = .none
            return formatter.string(from: NSNumber(value: result)) ?? "\(result)"
        }
        
        return "\(result)"
    }
    
    func processDeleteLast(for expression: inout String) -> String {
        if expression.isEmpty {
            return "0"
        } else if expression.count > 1 {
            expression.removeLast()
        } else {
            expression = "0"
        }
        return expression
    }
    
    func processEraseAll(for expression: inout String) -> String {
        expression = "0"
        return expression
    }
    
    func processParenthesis(_ paren: String, for expression: inout String) -> String {
        if paren == Op.leftParenthesis.rawValue {
            if expression == "0" { expression = "" }
            if let last = expression.last, last == Character(Op.decimal.rawValue) {
                expression.removeLast()
            }
            if let last = expression.last, Double(String(last)) != nil || String(last) == Op.rightParenthesis.rawValue {
                expression.append(Op.multiplication.rawValue)
            }
        } else if paren == Op.rightParenthesis.rawValue {
            if let last = expression.last, last == Character(Op.decimal.rawValue) {
                expression.removeLast()
            }
            let arithmeticOperators: [Character] = ["+","-", "×", "÷"]
            if let last = expression.last, arithmeticOperators.contains(last) {
                expression.removeLast()
            }
        }
        expression.append(paren)
        return expression
    }
    
    func processDecimal(for expression: inout String) -> String {
        let numberComponents = expression.components(separatedBy: CharacterSet(charactersIn: "÷×-+()"))
        
        if let lastComponent = numberComponents.last, lastComponent.contains(Op.decimal.rawValue) {
            return expression
        }
        if let last = expression.last, !last.isNumber {
            expression.append("0")
        }
        expression.append(Op.decimal.rawValue)
        return expression
    }
    
    func processNumber(_ number: String, for expression: inout String) -> String {
        // Avoid leading zero issues.
        let numberComponents = expression.components(separatedBy: CharacterSet(charactersIn: "÷×-+()"))
        if let lastComponent = numberComponents.last, lastComponent == "0", Double(number) != nil, expression.first != "0" {
            expression.removeLast()
        }
        if expression == "0" { expression = "" }
        if let last = expression.last, String(last) == Op.rightParenthesis.rawValue {
            // Insert implicit multiplication.
            expression.append(Op.multiplication.rawValue)
        }
        expression.append(number)
        return expression
    }
}

