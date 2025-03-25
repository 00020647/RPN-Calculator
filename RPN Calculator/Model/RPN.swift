//
//  RPN.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//

import Foundation

final class RPN{
    //MARK: - Parsing Values between Methods
    func calculate(_ input: String)-> Decimal{
        let arrayOfCharacters: [String] = stringToArray(input)
        let rpnExpression: [String] = convertToRPN(arrayOfCharacters)
        let result: Decimal = calculateResult(rpnExpression)
        return result
    }
    
    func stringToArray(_ input: String) -> [String] {
        var array: [String] = []
        var numberContainer = ""
        var lastChar: Character? = nil

        for element in input {
            if ExpressionHelper.isOperator(element) {
                if element == Character(Op.subtraction.rawValue) {
                    if lastChar == nil ||
                        ExpressionHelper.isOperator(lastChar!) ||
                        lastChar == Character(Op.leftParenthesis.rawValue) {
                        
                        if !numberContainer.isEmpty {
                            array.append(numberContainer)
                            numberContainer = ""
                        }
                        array.append("0")
                        array.append(String(element))
                    } else {
                        if !numberContainer.isEmpty {
                            array.append(numberContainer)
                            numberContainer = ""
                        }
                        array.append(String(element))
                    }
                } else {
                    if !numberContainer.isEmpty {
                        array.append(numberContainer)
                        numberContainer = ""
                    }
                    array.append(String(element))
                }
            } else {
                numberContainer.append(element)
            }
            lastChar = element
        }
        
        if !numberContainer.isEmpty {
            array.append(numberContainer)
        }
        
        return array
    }

    
    //MARK: - Converting to RPN
    func convertToRPN(_ input: [String]) -> [String] {
        var rpnForm: [String] = []
        
        var stackOperators: Stack<String> = Stack<String>()
        
        for character in input {
            if Double(character) != nil{
                rpnForm.append(character)
            }else {
                switch character {
                case Op.leftParenthesis.rawValue:
                    stackOperators.push(character)
                    
                case Op.rightParenthesis.rawValue:
                    while let top = stackOperators.peek(), top != Op.leftParenthesis.rawValue {
                        guard let canBePopped = stackOperators.pop() else {break}
                        rpnForm.append(canBePopped)
                    }
                    _ = stackOperators.pop()
                default:
                    while let topStackOperator = stackOperators.peek(),
                          ExpressionHelper.getPriority(topStackOperator) >= ExpressionHelper.getPriority(character) {
                        guard let topOperator = stackOperators.pop() else { break }
                        rpnForm.append(topOperator)
                    }
                    stackOperators.push(character)
                }
            }
        }
        while let op = stackOperators.pop(){
            rpnForm.append(op)
        }
        return rpnForm
    }
    
    
    //MARK: - Calculating result
    func calculateResult(_ output: [String])-> Decimal
    {
        var total: Decimal = 0.0
        
        var stack: Stack<Decimal> = Stack<Decimal>()
        
        for character in output {
            
            if let decimalNumber = Double(character) {
                stack.push(Decimal(decimalNumber))
            }
            
            else {
                guard let lastNumber = stack.pop(), let preLastNumber = stack.pop() else { break }
                
                switch character {
                case Op.addition.rawValue:
                    total = preLastNumber + lastNumber; break
                case Op.subtraction.rawValue:
                    total = preLastNumber - lastNumber; break
                case Op.multiplication.rawValue:
                    total = preLastNumber * lastNumber; break
                case Op.division.rawValue:
                    total = preLastNumber / lastNumber; break
                default:
                    break
                }
                let result = total
                stack.push(result)
            }
        }
        return stack.peek() ?? 0.0
    }
    
    
}
