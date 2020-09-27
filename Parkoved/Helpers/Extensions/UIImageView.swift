//
//  UIImageView.swift
//  Parkoved
//
//  Created by Sergey Kotov on 27.09.2020.
//

import UIKit

extension UIImageView {
    func setTintColor(_ color : UIColor) {
        if let image = self.image {
            self.image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        }
        self.tintColor = color
    }
}
