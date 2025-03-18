//
//  NumberPad.swift
//  RPN Calculator
//
//  Created by Sukhrob on 14/03/25.
//

import UIKit

final class NumberPad: UIStackView {
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        
        return stackView
    }()
    
    func createRowStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainStackView)
        clipsToBounds = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButtons(with rowsCharacters: [[String]]){
        for row in rowsCharacters{
            
            let rowStackView = createRowStackView()
            
            for character in row {
                let button = ButtonStyle.createButton(with: character)
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
            }
            mainStackView.addArrangedSubview(rowStackView)
        }
    }
    
    
    weak var delegate: ButtonActionProtocol?
    @objc func buttonTapped(_ sender: UIButton){
        if let text = sender.titleLabel?.text{
            delegate?.btnReceiver(buttonInput:text)
        }
    }
}

protocol ButtonActionProtocol: AnyObject {
    func btnReceiver(buttonInput: String)
}

