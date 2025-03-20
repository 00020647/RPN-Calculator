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

extension ViewController {
    func setupUI() {
        let labelView = LabelViewModel()
        view.addSubview(labelView.labelScrollView)
        
        //        resultLabel.backgroundColor = .purple
        // Add the resultLabel to the scroll view's content layout.
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for the scroll view relative to the safe area.
        NSLayoutConstraint.activate([
            labelView.labelScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            labelView.labelScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelView.labelScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelView.labelScrollView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        //        containerView.backgroundColor = UIColor.blue
        
        labelView.labelScrollView.addSubview(labelView.containerView)
        NSLayoutConstraint.activate([
            labelView.containerView.topAnchor.constraint(equalTo: labelView.labelScrollView.topAnchor),
            labelView.containerView.leadingAnchor.constraint(equalTo: labelView.labelScrollView.leadingAnchor),
            labelView.containerView.trailingAnchor.constraint(equalTo: labelView.labelScrollView.trailingAnchor),
            // Match the container's height to the scroll view's visible height.
            labelView.containerView.heightAnchor.constraint(equalTo: labelView.labelScrollView.frameLayoutGuide.heightAnchor),
            // Ensure the container's width is at least as wide as the scroll view.
            labelView.containerView.widthAnchor.constraint(greaterThanOrEqualTo: labelView.labelScrollView.frameLayoutGuide.widthAnchor)
        ])
        
        // Add resultLabel to the containerView.
        labelView.containerView.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: labelView.containerView.topAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: labelView.containerView.bottomAnchor),
            // Pin the trailing edge with padding.
            resultLabel.trailingAnchor.constraint(equalTo: labelView.containerView.trailingAnchor, constant: -20),
            // Allow the label to grow; its leading edge is at least a set distance from the container's leading.
            resultLabel.leadingAnchor.constraint(greaterThanOrEqualTo: labelView.containerView.leadingAnchor, constant: 20)
        ])
        
        
        
        // In your view controller, when setting up the scroll view:
        labelView.labelScrollView.transform = CGAffineTransform(scaleX: -1, y: 1)
        labelView.containerView.transform = CGAffineTransform(scaleX: -1, y: 1)
        
    }
}


