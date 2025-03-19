//
//  ViewController.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//

import UIKit

let resultLabel = ResultLabel()

class ViewController: UIViewController, ButtonActionProtocol{
    
    let numberPad = NumberPad()
    
    let rpn = RPN()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
        
        print(stringToArray("5-2+2(2*2)-2"))
    }
    
    
    
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let labelScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private func fetchData(){
        let buttonCharacters = [
            ["A","(",")","÷"],
            ["7","8","9","×"],
            ["4","5","6","-"],
            ["1","2","3","+"],
            ["⌫", "0",".", "="]
        ]
        numberPad.configureButtons(with: buttonCharacters)
        numberPad.delegate = self
        view.addSubview(numberPad)
    }
    private func setupUI() {
        view.addSubview(labelScrollView)
        
        //        resultLabel.backgroundColor = .purple
        // Add the resultLabel to the scroll view's content layout.
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for the scroll view relative to the safe area.
        NSLayoutConstraint.activate([
            labelScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            labelScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelScrollView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        //        containerView.backgroundColor = UIColor.blue
        
        labelScrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: labelScrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: labelScrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: labelScrollView.trailingAnchor),
            // Match the container's height to the scroll view's visible height.
            containerView.heightAnchor.constraint(equalTo: labelScrollView.frameLayoutGuide.heightAnchor),
            // Ensure the container's width is at least as wide as the scroll view.
            containerView.widthAnchor.constraint(greaterThanOrEqualTo: labelScrollView.frameLayoutGuide.widthAnchor)
        ])
        
        // Add resultLabel to the containerView.
        containerView.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            // Pin the trailing edge with padding.
            resultLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            // Allow the label to grow; its leading edge is at least a set distance from the container's leading.
            resultLabel.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: 20)
        ])
        
        view.backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 44/255, alpha: 1)
        
        print(labelScrollView.contentOffset)
        
        // In your view controller, when setting up the scroll view:
        labelScrollView.transform = CGAffineTransform(scaleX: -1, y: 1)
        containerView.transform = CGAffineTransform(scaleX: -1, y: 1)
        
    }
}


