//
//  LabelController.swift
//  RPN Calculator
//
//  Created by Sukhrob on 17/03/25.
//

import UIKit

extension ViewController {
    
    func btnReceiver(buttonInput: String) {
        
        guard var stringExpression = resultLabel.text else { return }
        
        let characterReceived = Character(buttonInput)
        
        let arithmeticOperators: [Character] = ["+","-", "×", "÷"]
        
        let numberComponents = stringExpression.components(separatedBy: CharacterSet(charactersIn: "÷×-+"))
        let lastDigit = numberComponents.last
        
        let allComponents = stringExpression.components(separatedBy: " ")
        
        
        switch characterReceived {
        case Op.addition.rawValue, Op.subtraction.rawValue,
            Op.multiplication.rawValue, Op.division.rawValue:
            
            if let last = stringExpression.last, last == Op.leftParenthesis.rawValue {
                // Exception: Allow the negative sign after a left parenthesis.
                if characterReceived == Op.subtraction.rawValue {
                    stringExpression.append(characterReceived)
                    resultLabel.text = stringExpression
                }
            } else {
                // If the last character is already an operator, remove it.
                if let last = stringExpression.last, arithmeticOperators.contains(last) {
                    stringExpression.removeLast()
                    if stringExpression.last == Op.leftParenthesis.rawValue{
                        break
                    }
                }
                stringExpression.append(characterReceived)
                resultLabel.text = stringExpression
            }
            
            
        case Op.equalSign.rawValue:
            let rpn = RPN()
            let result = rpn.calculate(stringExpression)
            
            if areParenthesesBalanced(in: stringExpression){
                stringExpression.append(Op.rightParenthesis.rawValue)
            }
            if result.remainder(dividingBy: 1) == 0 {
                let numberFormatter = NumberFormatter()
                numberFormatter.minimumFractionDigits = 0
                numberFormatter.numberStyle = .none
                let formattedResult = numberFormatter.string(from: NSNumber(value: result))
                resultLabel.text = formattedResult
            } else {
                resultLabel.text = "\(result)"
            }
            print(allComponents)
            
        case Op.deleteLast.rawValue:
            guard (resultLabel.text != "") else { return resultLabel.text = "0"}
            if resultLabel.text?.count != 1 {
                resultLabel.text?.removeLast()
            }else if resultLabel.text?.count == 1{
                resultLabel.text = "0"
            }
            
        case Op.eraseAll.rawValue:
            guard resultLabel.text != "0" else { return }
            resultLabel.text = "0"
            
        case Op.leftParenthesis.rawValue:
            if stringExpression == "0"{
                stringExpression = ""
                resultLabel.text = stringExpression
            }
            
            if (stringExpression.last?.isNumber == true) || stringExpression.last == Op.rightParenthesis.rawValue
            {
                stringExpression.append(Op.multiplication.rawValue)
                stringExpression.append(Op.leftParenthesis.rawValue)
                resultLabel.text = stringExpression
            }else {
                stringExpression.append(characterReceived)
                resultLabel.text = stringExpression
            }
        case Op.decimal.rawValue:
            if ((lastDigit?.contains(Op.decimal.rawValue)) == true){
                break
            }
            else {
                stringExpression.append(characterReceived)
                resultLabel.text = stringExpression
            }
        default:
            if lastDigit == "0", characterReceived.isNumber, stringExpression.first != "0"{
                return
            }
            if stringExpression == "0" {
                stringExpression = ""
            }
            if resultLabel.text == ""{
                resultLabel.text = "0"
            }
            
            resultLabel.text = "\(stringExpression)\(buttonInput)"
            print("\(stringExpression)\(buttonInput)")
        }
    }
    
    /// Returns true if the expression has balanced parentheses.
    func areParenthesesBalanced(in expression: String) -> Bool {
        var count = 0
        for char in expression {
            if char == Op.leftParenthesis.rawValue {
                count += 1
            } else if char == Op.rightParenthesis.rawValue {
                count -= 1
            }
            // If at any point we have more right than left, it’s unbalanced.
            if count < 0 { return true }
        }
        return count == 0
    }

}
