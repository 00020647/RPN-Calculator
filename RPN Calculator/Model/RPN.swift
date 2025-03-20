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
            if ExpressionHelper.isOperator(element) == false {
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
            if Double(character) != nil{
                rpnForm.append(character)
            }else {
                switch character {
                case Op.leftParenthesis.rawValue:
                    stackOperators.push(character)
                    
                case Op.rightParenthesis.rawValue:
                    while let top = stackOperators.peek(), top != Op.leftParenthesis.rawValue {
                        rpnForm.append(stackOperators.pop()!)
                    }
                    // Pop and discard the left parenthesis.
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
    func calculateResult(_ output: [String])-> Double
    {
        var total: Double = 0.0
        
        var stack: Stack<Double> = Stack<Double>()
        
        for character in output { 
            
            if Double(character) != nil{
                stack.push(Double(character) ?? 0)
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
                let result = round(total * 1e10) / 1e10
                stack.push(result)
            }
        }
        return stack.peek() ?? 0.0
    }
    
    
}
