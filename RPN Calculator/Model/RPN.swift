//
//  RPN.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//

import Foundation

final class RPN{
    //MARK: - Parsing Values between Methods
    func calculate(_ input: String)-> Double{
        let rpnExpression: String = convertToRPN(input)
        let result: Double = calculateResult(rpnExpression)
        return result
    }
    
    //MARK: - Converting to RPN
    func convertToRPN(_ input: String) -> String {
        var rpnForm: String = ""
        
        var stackOperators: Stack<Character> = Stack<Character>()
        
        var index = input.startIndex
        
        let delimeter = " "
        
        while index < input.endIndex{
            
            if ExpressionHelper.isDelimiter(input[index]){
                index = input.index(after: index)
                continue
            }
            
            if input[index].isNumber {
                while index < input.endIndex &&
                        !ExpressionHelper.isDelimiter(input[index])
                        && !ExpressionHelper.isOperator(input[index]){
                    rpnForm.append(input[index])
                    index = input.index(after: index)
                }
                rpnForm.append(delimeter)
                continue
            }
            
            if ExpressionHelper.isOperator(input[index]){
                switch input[index] {
                case Op.leftParenthesis.rawValue:
                    stackOperators.push(input[index])
                case Op.rightParenthesis.rawValue:
                    guard let lastOperator = stackOperators.pop() else {break}
                    var operatorStackItem = lastOperator
                    while operatorStackItem != Op.leftParenthesis.rawValue{
                        rpnForm.append(operatorStackItem)
                        rpnForm.append(delimeter)
                        guard let canBePopped = stackOperators.pop() else { break }
                        operatorStackItem = canBePopped
                    }
                default:
                    while let topStackOperator = stackOperators.peek(),
                          ExpressionHelper.getPriority(topStackOperator) >= ExpressionHelper.getPriority(input[index]) {
                        guard let topOperator = stackOperators.pop() else { break }
                        rpnForm.append(topOperator)
                        rpnForm.append(delimeter)
                    }
                    stackOperators.push(input[index])
                }
            }
            
            index = input.index(after: index)
            

        }
        while stackOperators.length() > 0 {
            guard let operatorToRemove = stackOperators.pop() else { break }
            rpnForm.append(operatorToRemove)
            rpnForm.append(delimeter)
        }
        
        return rpnForm
    }
    
    
    //MARK: - Calculating result
    func calculateResult(_ output: String)-> Double
    {
        var total: Double = 0.0

        var stack: Stack<Double> = Stack<Double>()
        
        var index = output.startIndex
        
        while index < output.endIndex {
            var wholeNumber: String = ""
            
            if output[index].isNumber{
                while index < output.endIndex && !ExpressionHelper.isDelimiter(output[index])
                        && !ExpressionHelper.isOperator(output[index]){
                    wholeNumber.append(output[index])
                    index = output.index(after: index)
                }
                stack.push(Double(wholeNumber) ?? 0)
            }
            
            else if ExpressionHelper.isOperator(output[index]){
                guard let lastNumber = stack.pop(), let preLastNumber = stack.pop() else { break }
                
                switch output[index] {
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
                let result = round(total * 1e10) / 1e10
                stack.push(result)
            }
            index = output.index(after: index)
        }
        
        return stack.peek() ?? 0.0
    }
}
