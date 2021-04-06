//
//  ProgressView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-05.
//

import Foundation
import UIKit

class ProgressView: UIView {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.width / 2
    }
}
