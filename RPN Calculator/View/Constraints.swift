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
//            mainStackView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -10),
            mainStackView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -20),
            mainStackView.heightAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 5/4)
        ])

        superview.addSubview(mainStackView)
    }
}




