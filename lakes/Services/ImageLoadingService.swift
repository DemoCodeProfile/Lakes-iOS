//
//  ImageLoadingService.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import UIKit
import SDWebImage

protocol ImageLoadingServiceProtocol: class {
    func loadImage(_ url: URL, closure: @escaping (UIImage?) -> Void)
}

class ImageLoadingService: ImageLoadingServiceProtocol {
    func loadImage(_ url: URL, closure: @escaping (UIImage?) -> Void) {
        SDWebImageManager.shared().loadImage(with: url, options: .cacheMemoryOnly, progress: nil) { (image, data, error, type, finished, url) in
            closure(image)
        }
    }
}

extension UIImage {
    func resizeImage(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
