//
//  ColorEnum.swift
//  RPN Calculator
//
//  Created by Sukhrob on 25/03/25.
//
import UIKit

enum ColorEnum {
    case Cyan
    case NumberColor
    case Gray
    case MainBackground
    
    var uiColor: UIColor {
        switch self {
        case .Cyan:
            return UIColor(red: 4/255, green: 199/255, blue: 191/255, alpha: 1)
        case .NumberColor:
            return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        case .Gray:
            return UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
        case .MainBackground:
            return UIColor(red: 32/255, green: 39/255, blue: 44/255, alpha: 1)
        }
    }
}
