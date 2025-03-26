//
//  Constraints.swift
//  RPN Calculator
//
//  Created by Sukhrob on 17/03/25.
//

import UIKit


extension ViewController {
    func setupUI() {
        view.backgroundColor = ColorEnum.MainBackground.uiColor
        
        view.addSubview(numberPad.mainStackView)
        view.addSubview(labelView.labelScrollView)
        labelView.labelScrollView.addSubview(labelView.containerView)
        labelView.containerView.addSubview(resultLabel)
        
        numberPad.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            numberPad.mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numberPad.mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numberPad.mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            numberPad.mainStackView.heightAnchor.constraint(equalTo: numberPad.mainStackView.widthAnchor, multiplier: 5/4),
        ])
        
        NSLayoutConstraint.activate([
            labelView.labelScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelView.labelScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelView.labelScrollView.bottomAnchor.constraint(equalTo: numberPad.mainStackView.topAnchor),
            labelView.labelScrollView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            labelView.containerView.topAnchor.constraint(equalTo: labelView.labelScrollView.topAnchor),
            labelView.containerView.leadingAnchor.constraint(equalTo: labelView.labelScrollView.leadingAnchor),
            labelView.containerView.trailingAnchor.constraint(equalTo: labelView.labelScrollView.trailingAnchor),
            labelView.containerView.heightAnchor.constraint(equalTo: labelView.labelScrollView.frameLayoutGuide.heightAnchor),
            labelView.containerView.widthAnchor.constraint(greaterThanOrEqualTo: labelView.labelScrollView.frameLayoutGuide.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: labelView.containerView.topAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: labelView.containerView.bottomAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: labelView.containerView.trailingAnchor, constant: -20),
            resultLabel.leadingAnchor.constraint(greaterThanOrEqualTo: labelView.containerView.leadingAnchor, constant: 20)
        ])
        
        labelView.labelScrollView.transform = CGAffineTransform(scaleX: -1, y: 1)
        labelView.containerView.transform = CGAffineTransform(scaleX: -1, y: 1)
    }

}


