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
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
