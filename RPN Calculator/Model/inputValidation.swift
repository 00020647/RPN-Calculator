//
//  inputValidation.swift
//  RPN Calculator
//
//  Created by Sukhrob Bekmuratov on 3/22/25.
//
import UIKit

protocol ExpressionHandling {
    func processOperator(_ currentOp: String, for expression: inout String) -> String
    
    func processEqual(for expression: inout String) -> String
    
    func processDeleteLast(for expression: inout String) -> String
    
    func processEraseAll(for expression: inout String) -> String
    
    func processParenthesis(_ paren: String, for expression: inout String) -> String
    
    func processDecimal(for expression: inout String) -> String
    
    func processNumber(_ number: String, for expression: inout String) -> String
}

extension ExpressionHandling {
    func processOperator(_ currentOp: String, for expression: inout String) -> String {
        
        if isResultInvalid(expression) {
            return expression
        }
        
        didCalculate = false
        
        if let last = expression.last, String(last) == Op.leftParenthesis.rawValue {
            if currentOp == Op.subtraction.rawValue {
                expression.append(currentOp)
            }
        }
        else {
            if disableOperLeftParenthesis(expression){
                return expression
            }
            if expression == Op.zero.rawValue || expression == Op.subtraction.rawValue {
                if currentOp == Op.subtraction.rawValue{
                    expression.removeLast()
                    expression.append(currentOp)
                }else{
                    expression = Op.zero.rawValue
                }
            }
            if let last = expression.last, arithmeticOperators.contains(String(last)) {
                expression.removeLast()
            }
            if expression.last == Character(Op.decimal.rawValue) {
                expression.removeLast()
            }
            expression.append(currentOp)
        }
        return expression
    }
    
    func processEqual(for expression: inout String) -> String {
        guard var last = expression.last else { return Op.zero.rawValue }

        while String(last) == Op.leftParenthesis.rawValue {
            expression.removeLast()
            last = expression.last ?? Character(Op.zero.rawValue)
        }
        
        while ExpressionHelper.isOperator(last), last != Character(Op.rightParenthesis.rawValue) {
            return expression
        }
        
        while !areParenthesesBalanced(in: expression), last != Character(Op.leftParenthesis.rawValue) {
            expression.append(Op.rightParenthesis.rawValue)
        }
        
        let rpn = RPN()
        let formatter = NumberFormatter()
        
        var getValue: Decimal = rpn.calculate(expression)
        didCalculate = true
        if getValue.isZero {
            getValue = 0
        }
        
        let result = NSDecimalNumber(decimal: getValue)
        let resultCount = result.stringValue
        
        print("Expression: \(expression)")
        print("Result: \(result)")
        
        if resultCount.count >= 9 {
            formatter.numberStyle = .scientific
            formatter.maximumFractionDigits = 9
            formatter.exponentSymbol = "e"
            return formatter.string(from: NSNumber(value: result.doubleValue)) ?? result.stringValue
        }else{
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 9
            return formatter.string(from: NSNumber(value: result.doubleValue)) ?? result.stringValue
        }
    }
    func processDeleteLast(for expression: inout String) -> String {
        if isResultInvalid(expression) {
            return expression
        }
        if expression.contains(Op.e.rawValue){
            expression.removeAll()
        }
        if expression.count > 1 {
            expression.removeLast()
        }
        else {
            expression = Op.zero.rawValue
        }
        return expression
    }
    
    func processEraseAll(for expression: inout String) -> String {
        expression = Op.zero.rawValue
        return expression
    }
    
    func processParenthesis(_ paren: String, for expression: inout String) -> String {
        if isResultInvalid(expression) {
            return expression
        }
        if paren == Op.leftParenthesis.rawValue {
            if expression == Op.zero.rawValue { expression.removeAll() }
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
            if areParenthesesBalanced(in: expression){
                return expression
            }
            if let last = expression.last, arithmeticOperators.contains(String(last)) {
                expression.removeLast()
            }
            if let last = expression.last, last == Character(Op.leftParenthesis.rawValue){
                return expression
            }
        }
        expression.append(paren)
        return expression
    }
    
    func processDecimal(for expression: inout String) -> String {
        if isResultInvalid(expression) {
            return expression
        }
        let numberComponents = expression.components(separatedBy: CharacterSet(charactersIn: allOperators))
        if let lastComponent = numberComponents.last, lastComponent.contains(Op.decimal.rawValue) {
            return expression
        }
        if let last = expression.last, !last.isNumber {
            expression.append(Op.zero.rawValue)
        }
        expression.append(Op.decimal.rawValue)
        return expression
    }
    
    func processNumber(_ number: String, for expression: inout String) -> String {
        if isResultInvalid(expression) {
            return expression
        }
        if didCalculate == true{
            expression.removeAll()
            didCalculate = false
        }
        let numberComponents = expression.components(separatedBy: CharacterSet(charactersIn: allOperators))
        if let lastComponent = numberComponents.last, lastComponent == Op.zero.rawValue, Double(number) != nil {
            expression.removeLast()
        }
        if expression == Op.zero.rawValue {
            expression.removeAll()
        }
        if let last = expression.last, String(last) == Op.rightParenthesis.rawValue {
            expression.append(Op.multiplication.rawValue)
        }
        expression.append(number)
        return expression
    }
}

