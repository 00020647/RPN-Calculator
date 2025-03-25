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
        
    }
}
let numberPad = NumberPad()
let labelView = LabelViewModel()
extension ViewController {
    func setupUI() {
        // First, add the subviews to the view hierarchy.
        view.addSubview(numberPad.mainStackView)
        view.addSubview(labelView.labelScrollView)
        labelView.labelScrollView.addSubview(labelView.containerView)
        labelView.containerView.addSubview(resultLabel)
        
        // Now disable autoresizing mask translation.
        numberPad.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        // Activate constraints for numberPad.mainStackView.
        NSLayoutConstraint.activate([
            numberPad.mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numberPad.mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numberPad.mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            numberPad.mainStackView.heightAnchor.constraint(equalTo: numberPad.mainStackView.widthAnchor, multiplier: 5/4),
        ])
        
        // Activate constraints for labelView.labelScrollView.
        NSLayoutConstraint.activate([
            labelView.labelScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelView.labelScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelView.labelScrollView.bottomAnchor.constraint(equalTo: numberPad.mainStackView.topAnchor),
            labelView.labelScrollView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // Activate constraints for labelView.containerView.
        NSLayoutConstraint.activate([
            labelView.containerView.topAnchor.constraint(equalTo: labelView.labelScrollView.topAnchor),
            labelView.containerView.leadingAnchor.constraint(equalTo: labelView.labelScrollView.leadingAnchor),
            labelView.containerView.trailingAnchor.constraint(equalTo: labelView.labelScrollView.trailingAnchor),
            labelView.containerView.heightAnchor.constraint(equalTo: labelView.labelScrollView.frameLayoutGuide.heightAnchor),
            labelView.containerView.widthAnchor.constraint(greaterThanOrEqualTo: labelView.labelScrollView.frameLayoutGuide.widthAnchor)
        ])
        
        // Activate constraints for resultLabel.
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


