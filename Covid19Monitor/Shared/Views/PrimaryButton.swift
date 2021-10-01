//
//  PrimaryButton.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/16.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit
@IBDesignable

class PrimaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 5
        UIView.animate(withDuration: 0.2) {
            self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            self.backgroundColor = .systemBlue
            self.setTitleColor(.white, for: .normal)
        }
    }
    
    override var alignmentRectInsets: UIEdgeInsets { 
        UIEdgeInsets(top: 0, left: -20, bottom: -30, right: -20)
    }
}

