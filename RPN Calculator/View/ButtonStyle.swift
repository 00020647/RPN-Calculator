//
//  ButtonStyle.swift
//  RPN Calculator
//
//  Created by Sukhrob on 14/03/25.
//

import UIKit




final class ButtonStyle: UIButton {
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            // No need to add a custom label since titleLabel is built in.
            clipsToBounds = true
        
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerRadius = self.bounds.height / 2
            
            //Цвета для отдельных кнопок
        }
        
        static func createButton(with digitChar: String) -> ButtonStyle {
            let button = ButtonStyle()
            button.setTitle(digitChar, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = .systemFont(ofSize: 40)
            button.setTitleColor(.white, for: .normal)
            
            switch button.titleLabel?.text ?? "" {
            case "÷", "×", "+", "-":
                button.backgroundColor = UIColor(red: 4/255, green: 199/255, blue: 191/255, alpha: 1.0)
            case "(", ")":
                button.backgroundColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
            case "A":
                button.backgroundColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1.0)
            default:
                button.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
            }
            
            return button
        }
}
struct ButtonStyleViewModel {
    let digitChar: String
}
