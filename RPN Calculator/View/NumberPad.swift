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

        
        return stackView
    }()
    
    private func createRowStackView() -> UIStackView {
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
    
    var buttonActionHandler: ((UIButton) -> Void)?
    
    @objc func buttonTapped(_ sender: UIButton){
        buttonActionHandler?(sender)
        print("Это замыкание в которой хранится функция", buttonActionHandler)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let superview = superview else { return }
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: superview.centerYAnchor, constant: -80),
            mainStackView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


