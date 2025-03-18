//
//  Constraints.swift
//  RPN Calculator
//
//  Created by Sukhrob on 17/03/25.
//

import UIKit

extension NumberPad {
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let superview = superview else { return }
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: superview.centerYAnchor, constant: -80),
            mainStackView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -20),
            mainStackView.heightAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 5/4)
        ])

        superview.addSubview(mainStackView)
    }
}

extension ResultLabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let superview = superview else { return }
        
//        NSLayoutConstraint.activate([
//            resultLabel.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 100),
//            resultLabel.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
//            resultLabel.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -20),
//            resultLabel.heightAnchor.constraint(equalToConstant: 80)
//        ])
    }
}

