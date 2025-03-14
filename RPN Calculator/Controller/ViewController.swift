//
//  ViewController.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//

import UIKit

class ViewController: UIViewController {

    let rpnCalculator = RPN()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let expression = "(2+5×(42-2))÷6"
        print(rpnCalculator.convertToRPN(expression))
        let result = rpnCalculator.calculate(expression) // ✅ Calling the function
        print("RPN Calculation Result: \(result)")
        
        let buttonStyle = ButtonStyle(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        buttonStyle.center = view.center
        buttonStyle.configure(with: ButtonStyleViewModel(digitChar: "1"))
        
        
        view.addSubview(buttonStyle)
        
        let biggestMainStack = NumberPad()
        NSLayoutConstraint.activate([
            biggestMainStack.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            biggestMainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            biggestMainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            biggestMainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        biggestMainStack.center = view.center
        view.addSubview(biggestMainStack)
    }


}

