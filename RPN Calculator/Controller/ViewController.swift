//
//  ViewController.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//

import UIKit

let resultLabel = ResultLabel()

class ViewController: UIViewController, ButtonActionProtocol{
    
    let numberPad = NumberPad()
    
    let rpn = RPN()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 44/255, alpha: 1)
        setupUI()
        fetchData()
        print(rpn.calculate("56-0.2-0.5"))
    }
    
    
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
