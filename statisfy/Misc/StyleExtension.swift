//
//  StyleExtension.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import Foundation
import UIKit

let scaleFactor = UIScreen.main.bounds.width/414

enum ViewControllerNames: String {
    case recentTracks = "recent_vc_info"
    case topTracks = "tracks_vc_info"
    case topArtists = "artists_vc_info"
}

enum Constants: CGFloat {
    
    case cornerRadius = 8.0
    case animationDuration = 0.375
    case headerViewHeight = 48
    case buttonSize = 36
}

struct SpinnerColors {
    
    static let normal = [UIColor.spotifyGreen]
}

extension UIFont {
    
    static var headerFont: UIFont {
        return UIFont.systemFont(ofSize: 36 * scaleFactor, weight: .bold)
    }
    
    static var welcomeFont: UIFont {
        return UIFont.systemFont(ofSize: 28 * scaleFactor, weight: .semibold)
    }

    static var welcomeSubtitleFont: UIFont {
        return UIFont.systemFont(ofSize: 22 * scaleFactor, weight: .semibold)
    }
    
    static var subHeaderFont: UIFont {
        return UIFont.systemFont(ofSize: 21 * scaleFactor, weight: .semibold)
    }
    
    static var subHeaderFontBold: UIFont {
        return UIFont.systemFont(ofSize: 21 * scaleFactor, weight: .bold)
    }
    
    static var bodyFont: UIFont {
        return UIFont.systemFont(ofSize: 16 * scaleFactor, weight: .regular)
    }
    
    static var tabBarFont: UIFont {
        return UIFont.systemFont(ofSize: 12 * scaleFactor, weight: .semibold)
    }
    
    static var alertFont: UIFont {
        return UIFont.systemFont(ofSize: 14 * scaleFactor, weight: .bold)
    }
    
    static var bodyFontBolded: UIFont {
        return UIFont.systemFont(ofSize: 16 * scaleFactor, weight: .semibold)
    }
    
    static var tableCellFontBolded: UIFont {
        return UIFont.systemFont(ofSize: 18 * scaleFactor, weight: .bold)
    }
    
    static var tableCellFontSemiBolded: UIFont {
        return UIFont.systemFont(ofSize: 18 * scaleFactor, weight: .semibold)
    }
}

extension UIColor {
    
    static var spotifyWhite: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    static var spotifyGreen: UIColor {
        return UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)
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

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
