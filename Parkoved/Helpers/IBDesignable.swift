//
//  IBDesignable.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit

@IBDesignable
class CornerView: UIView { // Класс для закругления вьюхи
    var updateRadius = true
    @IBInspectable var cornerRadius: CGFloat = -1 {
        didSet {
            self.updateRadius = false
            //self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.masksToBounds = true
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor : UIColor = UIColor.clear {
        didSet {
            
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if updateRadius {
            cornerRadius = min(bounds.width, bounds.height) / 2
            updateRadius = false
        }
        self.layer.cornerRadius = (cornerRadius < 0) ? min(bounds.width, bounds.height) / 2 : cornerRadius
        self.layer.borderColor = borderColor.cgColor
    }
}

class RoundGradientButton: UIButton { // Класс для закругления кнопок
    var colors: [CGColor] = [UIColor.clear.cgColor,UIColor.clear.cgColor]
    var startPoint = CGPoint(x: 0, y: 0)
    var endPoint = CGPoint(x: 1, y: 1)
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.masksToBounds = true
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var fromColor : UIColor = UIColor.clear {
        didSet {
            self.colors[0] = fromColor.cgColor
        }
    }
    
    @IBInspectable var toColor : UIColor = UIColor.clear {
        didSet {
            self.colors[1] = toColor.cgColor
        }
    }
    
    @IBInspectable var start : CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            self.startPoint = start
        }
    }
    
    @IBInspectable var end : CGPoint = CGPoint(x: 1, y: 1) {
        didSet {
            self.endPoint = end
        }
    }
    
    //@IBInspectable var fillDirection:
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = self.colors
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        //self.layer.addSublayer(layer)
        self.layer.insertSublayer(layer, at: 0)
    }
}

/*class GradientButton: UIButton {
 let gradientLayer = CAGradientLayer()
 
 @IBInspectable
 var fromColor: UIColor? {
 didSet {
 setGradient(fromColor, toColor)
 }
 }
 
 @IBInspectable
 var toColor: UIColor? {
 didSet {
 setGradient(fromColor, toColor)
 }
 }
 
 private func setGradient(_ topGradientColor: UIColor?,_ bottomGradientColor: UIColor?) {
 if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
 gradientLayer.frame = bounds
 gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
 gradientLayer.startPoint = CGPoint(x: 0, y: 0)
 gradientLayer.endPoint = CGPoint(x: 1, y: 1)
 gradientLayer.borderColor = layer.borderColor
 gradientLayer.borderWidth = layer.borderWidth
 gradientLayer.cornerRadius = layer.cornerRadius
 gradientLayer.cornerRadius = min(bounds.width, bounds.height) / 2
 layer.insertSublayer(gradientLayer, at: 0)
 } else {
 gradientLayer.removeFromSuperlayer()
 }
 }
 }*/

class RoundButton: UIButton { // Класс для закругления кнопок
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.masksToBounds = true
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor : UIColor = UIColor.clear
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
}

class RoundField: UITextField { // Класс для закругления кнопок
    
    var y : CGFloat = 0
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.masksToBounds = true
            self.layer.borderWidth = borderWidth
            self.layer.cornerRadius = self.bounds.size.height / 2.0
        }
    }
    @IBInspectable var borderColor : UIColor = UIColor.clear
    
    @IBInspectable var verticalPosition : CGFloat = 0 {
        didSet {
            self.y = verticalPosition
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = min(bounds.width, bounds.height) / 2
        // // print("layoutSubviews \(self.layer.cornerRadius)")
        
        
        //self.drawPlaceholder(in: CGRect(x: bounds.origin.x + self.layer.cornerRadius, y: bounds.origin.y + 2, width: bounds.width - self.layer.cornerRadius * 2, height: bounds.height))
        
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        // // print("placeholderRect: \(self.layer.cornerRadius)")
        //super.textRect(forBounds: bounds)
        return CGRect(x: bounds.origin.x + self.layer.cornerRadius, y: bounds.origin.y + y, width: bounds.width - self.layer.cornerRadius * 2, height: bounds.height)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        //super.textRect(forBounds: bounds)
        
        return CGRect(x: bounds.origin.x + self.layer.cornerRadius, y: bounds.origin.y + self.y, width: bounds.width - self.layer.cornerRadius * 2, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        //super.editingRect(forBounds: bounds)
        
        return CGRect(x: bounds.origin.x + self.layer.cornerRadius, y: bounds.origin.y + self.y, width: bounds.width - self.layer.cornerRadius * 2, height: bounds.height)
    }
    
}

class CustomCollection: UICollectionView {
    
    /*   @IBInspectable var topEdge : CGFloat = 0
     @IBInspectable var leftEdge : CGFloat = 0
     @IBInspectable var bottomEdge : CGFloat = 0
     @IBInspectable var rightEdge : CGFloat = 0*/
    @IBInspectable var rows : CGFloat = 1 {
        didSet {
            if rows < 1 {rows = 1}
        }
    }
    @IBInspectable var columns : CGFloat = 1 {
        didSet {
            if columns < 1 {columns = 1}
        }
    }
    
    let flowLayout = UICollectionViewFlowLayout()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        //flowLayout.sectionInset = UIEdgeInsetsMake(topEdge, leftEdge, bottomEdge, rightEdge)
        flowLayout.itemSize = CGSize(width: self.bounds.width / columns, height: self.bounds.height / rows)
        self.collectionViewLayout = flowLayout
    }
}

class RoundTable: UITableView { // Класс для закругления скроллируемых элементов
    var updateRadius = true
    //var cornerRadius: CGFloat?
    @IBInspectable var cornerRadius: CGFloat = -1 {
        didSet {
            self.updateRadius = false
            //self.layer.cornerRadius = cornerRadius
        }
        
    }
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.masksToBounds = true
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor : UIColor = UIColor.clear
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if updateRadius {
            cornerRadius = min(bounds.width, bounds.height) / 2
            updateRadius = false
        }
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = (cornerRadius < 0) ? min(bounds.width, bounds.height) / 2 : cornerRadius
    }
}

class RoundTextView: UITextView { // Класс для закругления скроллируемых элементов
    var updateRadius = true
    //var cornerRadius: CGFloat?
    @IBInspectable var cornerRadius: CGFloat = -1 {
        didSet {
            self.updateRadius = false
            //self.layer.cornerRadius = cornerRadius
        }
        
    }
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.masksToBounds = true
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor : UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if updateRadius {
            cornerRadius = min(bounds.width, bounds.height) / 2
            updateRadius = false
        }
        self.layer.cornerRadius = (cornerRadius < 0) ? min(bounds.width, bounds.height) / 2 : cornerRadius
        self.textContainerInset = UIEdgeInsets.init(top: self.layer.cornerRadius / 2, left: self.layer.cornerRadius, bottom: self.layer.cornerRadius / 2, right: self.layer.cornerRadius)
        self.textContainer.lineFragmentPadding = 0
        
    }
}
/** Переключатель */
class CheckBox: UIButton {
    var uncheckedImage = UIImage(named: "icon_disable")?.withRenderingMode(.alwaysTemplate)
    var checkedImage = UIImage(named: "icon_enable")?.withRenderingMode(.alwaysTemplate)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.customize()
    }
    
    func customize(){
        self.setImage(self.uncheckedImage, for: .normal)
        self.setImage(self.checkedImage, for: .selected)
        self.addTarget(self, action: #selector(self.buttonChecked(_:)), for: .touchUpInside)
    }
    
    @objc func buttonChecked(_ sender:AnyObject){
        self.isSelected = !self.isSelected
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
