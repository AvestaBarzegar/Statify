//
//  DownloadedImageView.swift
//  statisfy-with-spotify
//
//  Created by Avesta Barzegar on 2021-03-11.
//

import Foundation
import UIKit 

// Maps URLS to UIImage
let imageCache = NSCache<AnyObject, AnyObject>()

class DownloadedImageView: UIImageView {

    var imageURL: NSURL?

    func lazyLoadImageUsingURL(urlString: String, placeholder: String?) {
        guard let url = NSURL(string: urlString.replacingOccurrences(of: " ", with: "")) else {
            debugPrint("URL could not be constructed")
            return
        }
        
        imageURL = url

        if placeholder == nil {
            image = nil
        }
        
        if let placeholderString = placeholder {
            image = UIImage(named: placeholderString)
        }
        
        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, _, error) in

            if error != nil {
                print(error as Any)
                return
            }

            DispatchQueue.main.async(execute: {

                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {

                    let resizedImage = imageToCache.downSample(width: 300)
                    if self.imageURL == url {
                        self.image = resizedImage
                    }
                    imageCache.setObject(resizedImage, forKey: url as AnyObject)
                }
            })
        }).resume()
    }
}
