//
//  UIView.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
//    func rotateView(_ targetView: UIView) {
//        UIView.animate(withDuration: 0, delay: 0.1, animations: {
//            targetView.transform = targetView.transform.rotated(by: CGFloat(Double.pi / 6))
//        }) { finished in
//            if self.spinner {
//                self.rotateView(targetView)
//            }
//        }
//    }
//    
//    var spinner: Bool {
//        set(newValue) {
//            DispatchQueue.main.async {
//                let size: CGFloat = 54
//                let window = UIScreen.main.bounds
//                print("Заданное значение в spinner \(String(describing: newValue))")
//                if newValue {
//                    if self.viewWithTag(777) == nil {
//                        let shadow = UIView(frame: window)
//                        shadow.backgroundColor = UIColor(red: 0, green: 86/255, blue: 163/255, alpha: 0.5)
//                        shadow.tag = 777
//                        self.addSubview(shadow)
//                        let spinner = UIImageView(image: UIImage(named: "spinner"))
//                        spinner.frame = CGRect(x: (window.width - size)/2, y: self.center.y, width: size, height: size)
//                        self.rotateView(spinner)
//                        shadow.addSubview(spinner)
//                    }
//                } else {
//                    if let shadow = self.viewWithTag(777) {
//                        UIView.animate(withDuration: 0.3, animations: {
//                            shadow.alpha = 0
//                        }) { finished in
//                            shadow.removeFromSuperview()
//                        }
//                    }
//                }
//            }
//        }
//        get {
//            return self.viewWithTag(777) != nil
//        }
//    }
}
