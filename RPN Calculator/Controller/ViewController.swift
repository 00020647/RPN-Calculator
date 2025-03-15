//
//  ViewController.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//

import UIKit

class ViewController: UIViewController {
    
    let rpnCalculator = RPN()
    let numberPad = NumberPad()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(numberPad) // Add NumberPad to the ViewController's
        view.backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 44/255, alpha: 1)
        
        numberPad.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberPad.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numberPad.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numberPad.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            numberPad.heightAnchor.constraint(equalToConstant: 500) // Adjust height as needed
        ])
        
        let buttonCharacters = [
            ["A","(",")","÷"],
            ["7","8","9","×"],
            ["4","5","6","-"],
            ["1","2","3","+"],
            ["0",".", "="]
        ]
        
        numberPad.configureButtons(with: buttonCharacters)
        
        numberPad.buttonActionHandler = { [weak self] button in
            self?.handleButtonAction(button)
            print("тут почему то эта функция пропадает", print(self?.handleButtonAction(button)))
        }
    }
    
    func handleButtonAction(_ sender: UIButton) {
        print("Button pressed: \(sender.currentTitle ?? "That")")
    }
}


