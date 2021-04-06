//
//  ProgressShapeLayer.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-05.
//

import Foundation
import UIKit

class ProgressShapeLayer: CAShapeLayer {
    
    public init(lineWidth: CGFloat) {
        super.init()
        
        self.strokeColor = UIColor.clear.cgColor
        self.lineWidth = lineWidth
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .round
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
