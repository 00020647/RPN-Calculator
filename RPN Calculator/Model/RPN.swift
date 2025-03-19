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
        let arrayOfCharacters: [String] = stringToArray(input)
        let rpnExpression: [String] = convertToRPN(arrayOfCharacters)
        let result: Double = calculateResult(rpnExpression)
        return result
    }
    
    
    func stringToArray(_ input: String)-> [String]{
        var array: [String] = []
        var number = String()
        
        for element in input{
            if element.isNumber {
                number.append(element)
            }
            else{
                if !number.isEmpty {
                    array.append(number)
                    number.removeAll()
                }
                array.append(String(element))
            }
        }
        if !number.isEmpty {
            array.append(number)
        }
        return array
    }
 
    
    //MARK: - Converting to RPN
    func convertToRPN(_ input: [String]) -> [String] {
        var rpnForm: [String] = []
        
        var stackOperators: Stack<String> = Stack<String>()
        
        for character in input {
            if let wholeNumber = Double(character){
                rpnForm.append(character)
            }else {
                switch character {
                case Op.leftParenthesis.rawValue:
                    stackOperators.push(character)
                case Op.rightParenthesis.rawValue:
                    guard let lastOperator = stackOperators.pop() else {break}
                    var operatorStackItem = lastOperator
                    while operatorStackItem != Op.leftParenthesis.rawValue{
                        rpnForm.append(operatorStackItem)
                        guard let canBePopped = stackOperators.pop() else { break }
                        operatorStackItem = canBePopped
                    }
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
        return rpnForm
    }
    
    
    //MARK: - Calculating result
    func calculateResult(_ output: [String])-> Double
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
