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
        
        let characterReceived = String(buttonInput)
        
        let arithmeticOperators: [Character] = ["+","-", "×", "÷"]
        
        let numberComponents = stringExpression.components(separatedBy: CharacterSet(charactersIn: "÷×-+()"))
        let lastDigit = numberComponents.last
        
        guard let lastCharacter = stringExpression.last else {return}
        var last = String(lastCharacter)
        
        
        switch characterReceived {
        case Op.addition.rawValue, Op.subtraction.rawValue,
            Op.multiplication.rawValue, Op.division.rawValue:
            
            if let last = stringExpression.last, String(last) == Op.leftParenthesis.rawValue {
                // Exception: Allow the negative sign after a left parenthesis.
                if characterReceived == Op.subtraction.rawValue {
                    stringExpression.append(characterReceived)
                    resultLabel.text = stringExpression
                }
            } else {

                if let last = stringExpression.last, arithmeticOperators.contains(last) {
                    stringExpression.removeLast()
                    if String(last) == Op.leftParenthesis.rawValue{
                        break
                    }
                }
                if last == Op.decimal.rawValue{
                    stringExpression.removeLast()
                }
                stringExpression.append(characterReceived)
                resultLabel.text = stringExpression
            }
            
            
        case Op.equalSign.rawValue:
            let rpn = RPN()
            
            if last == Op.leftParenthesis.rawValue{
                while Double(last) == nil{
                    print(stringExpression)
                    stringExpression.removeLast()
                    let lastString = stringExpression.last?.description ?? ""
                    last = lastString
                }
            }
            
            if areParenthesesBalanced(in: stringExpression) == false{
                while areParenthesesBalanced(in: stringExpression) == false{
                    stringExpression.append(Op.rightParenthesis.rawValue)
                }
                print(stringExpression)
            }

            let result = rpn.calculate(stringExpression)
            
            if result.remainder(dividingBy: 1) == 0 {
                let numberFormatter = NumberFormatter()
                numberFormatter.minimumFractionDigits = 0
                numberFormatter.numberStyle = .none
                let formattedResult = numberFormatter.string(from: NSNumber(value: result))
                resultLabel.text = formattedResult
            } else {
                resultLabel.text = "\(result)"
            }
            
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
            if last == Op.decimal.rawValue{
                stringExpression.removeLast()
            }
            if Double(last) != nil || last == Op.rightParenthesis.rawValue
            {
                stringExpression.append(Op.multiplication.rawValue)
                stringExpression.append(Op.leftParenthesis.rawValue)
                resultLabel.text = stringExpression
            }else {
                stringExpression.append(characterReceived)
                resultLabel.text = stringExpression
            }
            
        case Op.rightParenthesis.rawValue:
            if last == Op.decimal.rawValue{
                stringExpression.removeLast()
            }
            if let last = stringExpression.last, arithmeticOperators.contains(last) {
                stringExpression.removeLast()
            }
            if areParenthesesBalanced(in: stringExpression) {
                return
            }
            if last == Op.leftParenthesis.rawValue{
                return
            }
            stringExpression.append(characterReceived)
            resultLabel.text = stringExpression
        case Op.decimal.rawValue:
            if ((lastDigit?.contains(Op.decimal.rawValue)) == true){
                return
            }
            if stringExpression.last?.isNumber != true {
                stringExpression.append("0")
                stringExpression.append(characterReceived)
                resultLabel.text = stringExpression
            }
            else {
                stringExpression.append(characterReceived)
                resultLabel.text = stringExpression
            }
        default:
            if lastDigit == "0", Double(characterReceived) != nil, stringExpression.first != "0"{
                stringExpression.removeLast()
            }
            if stringExpression == "0" {
                stringExpression = ""
            }
            if resultLabel.text == ""{
                resultLabel.text = "0"
            }
            if last == Op.rightParenthesis.rawValue{
                stringExpression.append(Op.multiplication.rawValue)
            }
            resultLabel.text = "\(stringExpression)\(buttonInput)"
            print("\(stringExpression)\(buttonInput)")
        }
    }
    
    //Можно Убрать
    /// Returns true if the expression has balanced parentheses.
    func areParenthesesBalanced(in expression: String) -> Bool {
        var count = 0
        for char in expression {
            let character = String(char)
            if character == Op.leftParenthesis.rawValue {
                count += 1
            } else if character == Op.rightParenthesis.rawValue {
                count -= 1
            }
            // If at any point we have more right than left, it’s unbalanced.
            if count < 0 { return false }
        }
        return count == 0
    }

}
