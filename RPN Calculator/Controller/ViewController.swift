//
//  ViewController.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//

import UIKit

let resultLabel = ResultLabel()

class ViewController: UIViewController, ButtonActionProtocol, ExpressionHandling{
    
    let numberPad = NumberPad()
    
    let rpn = RPN()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 44/255, alpha: 1)
        setupUI()
        fetchData()
    }
    
    
    //TODO: Multiply by utself if no second operand
    
    func fetchData(){
        let buttonCharacters = [
            ["A","(",")","÷"],
            ["7","8","9","×"],
            ["4","5","6","-"],
            ["1","2","3","+"],
            ["⌫", "0",".", "="]
        ]
        numberPad.configureButtons(with: buttonCharacters)
        numberPad.delegate = self
        view.addSubview(numberPad)
    }
}

extension ViewController {
    
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
