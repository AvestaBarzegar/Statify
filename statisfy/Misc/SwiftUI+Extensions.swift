//
//  SwiftUI+Extensions.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-08-25.
//

import SwiftUI
import UIKit

public extension Font {
  init(uiFont: UIFont) {
    self = Font(uiFont as CTFont)
  }
}

extension Text {
    func font(_ font: UIFont) -> Text {
        return self.font(Font(uiFont: font))
    }
    
    func textColor(_ color: UIColor) -> Text {
        return foregroundColor(Color(color))
    }
}

extension EdgeInsets {

	init(vertical: CGFloat, horizontal: CGFloat) {
		self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
	}

}
