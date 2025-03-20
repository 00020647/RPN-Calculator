//
//  ResultLabel.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//

import UIKit

final class ResultLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = .right
        self.textColor = .white
        self.text = "0"
        self.font = UIFont.systemFont(ofSize: 50)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class LabelViewModel: UIView{
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
}
