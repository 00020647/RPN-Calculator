//
//  ButtonStyle.swift
//  RPN Calculator
//
//  Created by Sukhrob on 14/03/25.
//

import UIKit

final class CustomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.bounds.width / 2
    }
    
    static func createButton(with digitChar: String) -> CustomButton {
        let button = CustomButton()
        
        button.setTitle(digitChar, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 40)
        button.setTitleColor(.white, for: .normal)
        
        
        switch button.titleLabel?.text{
        case Op.addition.rawValue, Op.subtraction.rawValue, Op.multiplication.rawValue, Op.division.rawValue, Op.equalSign.rawValue:
            button.backgroundColor = ColorEnum.Cyan.uiColor
        case Op.leftParenthesis.rawValue, Op.rightParenthesis.rawValue,
            Op.eraseAll.rawValue, Op.deleteLast.rawValue:
            button.backgroundColor = ColorEnum.Gray.uiColor
        default:
            button.backgroundColor = ColorEnum.NumberColor.uiColor
        }
        return button
    }
}
