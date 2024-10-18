//
//  UIImageView.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import SDWebImage
import UIKit

extension UIImageView {
    public func setImage(with url: URL?, placeholderImage placeholder: UIImage? = nil) {
        sd_setImage(with: url, placeholderImage: placeholder)
    }
}
