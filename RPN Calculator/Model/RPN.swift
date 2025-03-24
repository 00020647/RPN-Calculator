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
        var numberContainer = String()
        var lastString: String? = nil
        
        for element in input{
            if ExpressionHelper.isOperator(element){
                if element == Character(Op.subtraction.rawValue), lastString == nil {
                    numberContainer.append(element)
                }
                else if element == Character(Op.subtraction.rawValue), let last = lastString, ExpressionHelper.isOperator(Character(last)){
                    numberContainer.append(element)
                }
                else{
                    if !numberContainer.isEmpty {
                        array.append(numberContainer)
                        numberContainer.removeAll()
                    }
                    array.append(String(element))
                }
                
            }else {
                numberContainer.append(element)
            }
            lastString = String(element)
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
                    // What the fuck is this ChatGPt
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
