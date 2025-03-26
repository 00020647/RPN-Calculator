//
//  ViewController.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//

import UIKit

let resultLabel = ResultLabel()

final class ViewController: UIViewController, ButtonActionProtocol, ExpressionHandling{
    
    let numberPad = NumberPad()
    
    let rpn = RPN()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
        print(rpn.stringToArray("7-52+4-8×9-4÷(8+6)"))
        print(rpn.convertToRPN(["7", "-", "52", "+", "4", "-", "8", "×", "9", "-", "4", "÷", "(", "8", "+", "6", ")"]))
        print(rpn.calculate("7-52+4-8×9-4÷(8+6)"))
    }
    
    
    //TODO: Multiply by utself if no second operand
    
    func fetchData(){
        numberPad.configureButtons(with: buttonCharacters)
        numberPad.delegate = self
    }
    
    func btnReceiver(buttonInput: String) {
        
        guard var stringExpression = resultLabel.text else { return }
        let characterReceived = buttonInput
        
        switch characterReceived {
        case Op.addition.rawValue, Op.subtraction.rawValue,
             Op.multiplication.rawValue, Op.division.rawValue:
            
            stringExpression = processOperator(characterReceived, for: &stringExpression)
            resultLabel.text = stringExpression
            
        case Op.equalSign.rawValue:
            stringExpression = processEqual(for: &stringExpression)
            resultLabel.text = stringExpression
            
            
        case Op.deleteLast.rawValue:
            stringExpression = processDeleteLast(for: &stringExpression)
            resultLabel.text = stringExpression
            
        case Op.eraseAll.rawValue:
            stringExpression = processEraseAll(for: &stringExpression)
            resultLabel.text = stringExpression
            
        case Op.leftParenthesis.rawValue, Op.rightParenthesis.rawValue:
            stringExpression = processParenthesis(characterReceived, for: &stringExpression)
            resultLabel.text = stringExpression
            
        case Op.decimal.rawValue:
            stringExpression = processDecimal(for: &stringExpression)
            resultLabel.text = stringExpression
            
        default:
            if didCalculate == true{
                stringExpression.removeAll()
                didCalculate = false
            }
            stringExpression = processNumber(characterReceived, for: &stringExpression)
            resultLabel.text = stringExpression
        }
    }
}
