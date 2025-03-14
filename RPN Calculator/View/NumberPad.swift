//
//  NumberPad.swift
//  RPN Calculator
//
//  Created by Sukhrob on 14/03/25.
//

import UIKit

final class NumberPad: UIStackView {

    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .red
        
        return stackView
    }()
    
    private let rowStackVIew: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let buttonCharacters = [
        ["A","(",")","÷"],
        ["7","8","9","×"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        ["0",".", "="]
    ]

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainStackView)
        clipsToBounds = true
        
        //MARK: - Round Corners
        layer.cornerRadius = self.bounds.height / 2
        layer.masksToBounds = true
        
        backgroundColor = .green
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButtons(with rowsCharacters: [[String]]){
        for row in rowsCharacters{
            for character in row {
                let button = ButtonStyleViewModel(digitChar: character)
                rowStackVIew.addArrangedSubview(button)
            }
            mainStackView.addArrangedSubview(rowStackVIew)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }

}
