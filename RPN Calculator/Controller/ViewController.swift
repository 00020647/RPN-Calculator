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
        
        
        
        
        let buttonStyle = ButtonStyle(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        buttonStyle.center = view.center
        buttonStyle.configure(with: ButtonStyleViewModel(digitChar: "1"))
        view.addSubview(buttonStyle)
        
        numberPad.configureButtons(with: [["A","(",")","÷"], ["7","8","9","×"],
                                   ["4","5","6","-"],
                                   ["1","2","3","+"],
                                   ["0",".", "="]])
        view.addSubview(numberPad) // Add NumberPad to the ViewController's
            
            numberPad.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                numberPad.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                numberPad.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                numberPad.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                numberPad.heightAnchor.constraint(equalToConstant: 300) // Adjust height as needed
            ])
        
    }


}

