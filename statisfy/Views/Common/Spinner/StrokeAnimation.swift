//
//  StrokeAnimation.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-05.
//

import Foundation
import UIKit

class StrokeAnimation: CABasicAnimation {
    
    // enum that defines if an animation is starting or ending
    enum StrokeType {
        case start
        case end
    }
    
    // MARK: - Initializers
    override init() {
        super.init()
    }
    
    init(type: StrokeType,
         beginTime: Double = 0.0,
         fromValue: CGFloat,
         toValue: CGFloat,
         duration: Double) {
        
        super.init()
        
        self.keyPath = type == .start ? "strokeStart" : "strokeEnd"
        
        self.beginTime = beginTime
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        self.timingFunction = .init(name: .easeInEaseOut)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
