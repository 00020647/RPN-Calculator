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
//            mainStackView.topAnchor.constraint(equalTo: superview.centerYAnchor, constant: -80),
            mainStackView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -20),
            mainStackView.heightAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 5/4)
        ])

        superview.addSubview(mainStackView)
    }
}
let numberPad = NumberPad()
let labelView = LabelViewModel()
extension ViewController {
    func setupUI() {
       
        view.addSubview(labelView.labelScrollView)

        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelView.labelScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelView.labelScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelView.labelScrollView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            labelView.labelScrollView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        
        labelView.labelScrollView.addSubview(labelView.containerView)
        NSLayoutConstraint.activate([
            labelView.containerView.topAnchor.constraint(equalTo: labelView.labelScrollView.topAnchor),
            labelView.containerView.leadingAnchor.constraint(equalTo: labelView.labelScrollView.leadingAnchor),
            labelView.containerView.trailingAnchor.constraint(equalTo: labelView.labelScrollView.trailingAnchor),
            labelView.containerView.heightAnchor.constraint(equalTo: labelView.labelScrollView.frameLayoutGuide.heightAnchor),
            labelView.containerView.widthAnchor.constraint(greaterThanOrEqualTo: labelView.labelScrollView.frameLayoutGuide.widthAnchor)
        ])
        
        labelView.containerView.addSubview(resultLabel)
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


