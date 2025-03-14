//
//  ButtonStyle.swift
//  RPN Calculator
//
//  Created by Sukhrob on 14/03/25.
//

import UIKit


struct ButtonStyleViewModel {
    let digitChar: String
}

final class ButtonStyle: UIButton {
    
    private let digitNumber: UILabel = {
        let digit = UILabel()
        digit.textAlignment = .center
        digit.textColor = UIColor.white
        digit.font = .systemFont(ofSize: 40)
        
        return digit
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(digitNumber)
        clipsToBounds = true
        
        //MARK: - Round Corners
        layer.cornerRadius = self.bounds.height / 2
        layer.masksToBounds = true
        
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ButtonStyleViewModel){
        digitNumber.text = viewModel.digitChar
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        digitNumber.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
}
