//
//  StyleExtension.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import Foundation
import UIKit

enum Constants: CGFloat {
    
    case cornerRadius = 8.0
    case animationDuration = 0.75
    case headerViewHeight = 48
    case buttonSize = 36
}

struct SpinnerColors {
    
    static let normal = [UIColor.spotifyGreen]
}

extension UIFont {
    
    static var headerFont: UIFont {
        return UIFont.systemFont(ofSize: 36, weight: .bold)
    }
    
    static var welcomeFont: UIFont {
        return UIFont.systemFont(ofSize: 28, weight: .semibold)
    }

    static var welcomeSubtitleFont: UIFont {
        return UIFont.systemFont(ofSize: 22, weight: .semibold)
    }
    
    static var subHeaderFont: UIFont {
        return UIFont.systemFont(ofSize: 21, weight: .semibold)
    }
    
    static var subHeaderFontBold: UIFont {
        return UIFont.systemFont(ofSize: 21, weight: .bold)
    }
    
    static var bodyFont: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    static var tabBarFont: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    
    static var bodyFontBolded: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    static var tableCellFontBolded: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    static var tableCellFontSemiBolded: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
}

extension UIColor {
    
    static var spotifyWhite: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    static var spotifyGreen: UIColor {
        return UIColor(red: 2/17, green: 43/51, blue: 32/85, alpha: 1)
    }
//    static var spotifyBlack: UIColor {
//        return UIColor(red: 5/51, green: 4/51, blue: 4/51, alpha: 1)
//    }
//
    static var spotifyGray: UIColor {
        return UIColor(red: 52/255, green: 52/255, blue: 74/255, alpha: 1)
    }
    
    static var backgroundColor: UIColor {
        return UIColor(red: 40/255, green: 36/255, blue: 44/255, alpha: 1)
    }
    static var backgroundColor2: UIColor {
        return UIColor(red: 67/255, green: 58/255, blue: 63/255, alpha: 1)
    }
    
    static var spotifyTurkoise: UIColor {
        return UIColor(red: 61/255, green: 90/255, blue: 108/255, alpha: 1)
    }
    static var spotifyLightGreen: UIColor {
        return UIColor(red: 114/255, green: 169/255, blue: 143/255, alpha: 1)
    }
    static var lightGreen: UIColor {
        return UIColor(red: 141/255, green: 233/255, blue: 105/255, alpha: 1)
    }
    static var pear: UIColor {
        return UIColor(red: 203/255, green: 239/255, blue: 67/255, alpha: 1)
    }
    static var backgroundComplementColor: UIColor {
        return UIColor(red: 56/255, green: 57/255, blue: 63/255, alpha: 1)
    }
    
}

extension UIImage {
    
    func downSample(width: CGFloat) -> UIImage {
        let aspectRatio = self.size.height / self.size.width
        let newWidth = self.size.width > width ? width : self.size.width
        let newHeight = newWidth * aspectRatio
        let newSize = CGSize(width: newWidth, height: newHeight)
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
}
