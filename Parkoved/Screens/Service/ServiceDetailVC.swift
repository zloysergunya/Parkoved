//
//  ServiceDetailVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 27.09.2020.
//

import UIKit

class ServiceDetailVC: FrameVC {

    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var finalSumLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var childrenCountLabel: UILabel!
    @IBOutlet weak var minusButton: UIImageView!
    @IBOutlet weak var plusButton: UIImageView!
    @IBOutlet weak var minusChildrenButton: UIImageView!
    @IBOutlet weak var plusChildrenButton: UIImageView!
    
    var count = 1
    var childrenCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaps()
        countFinalSum()
        setupImageCollection()
    }
    
    func addTaps() {
        let minusTap = UITapGestureRecognizer(target: self, action: #selector(minusTapAction))
        minusButton.isUserInteractionEnabled = true
        minusButton.setTintColor(.gray)
        minusButton.addGestureRecognizer(minusTap)
        let plusTap = UITapGestureRecognizer(target: self, action: #selector(plusTapAction))
        plusButton.isUserInteractionEnabled = true
        plusButton.setTintColor(.gray)
        plusButton.addGestureRecognizer(plusTap)
        let minusChildrenTap = UITapGestureRecognizer(target: self, action: #selector(minusChildrenTapAction))
        minusChildrenButton.isUserInteractionEnabled = true
        minusChildrenButton.setTintColor(.gray)
        minusChildrenButton.addGestureRecognizer(minusChildrenTap)
        let plusChildrenTap = UITapGestureRecognizer(target: self, action: #selector(plusChildrenTapAction))
        plusChildrenButton.isUserInteractionEnabled = true
        plusChildrenButton.setTintColor(.gray)
        plusChildrenButton.addGestureRecognizer(plusChildrenTap)
    }

    @IBAction func payWithApplePay(_ sender: Any) {
        self.dialog(title: "Спасибо за покупку!", message: "Проверьте вкладку “Билеты” внизу ;)", default: nil, cancel: "Закрыть", onAgree: nil, onCancel: { _ in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func minusTapAction(sender: UITapGestureRecognizer) {
        count -= 1
        if count <= 0 {
            count = 0
        }
        countLabel.text = "\(count)"
        countFinalSum()
    }
    
    @IBAction func plusTapAction(sender: UITapGestureRecognizer) {
        count += 1
        if count > 99 {
            count = 99
        }
        countLabel.text = "\(count)"
        countFinalSum()
    }
    
    @IBAction func minusChildrenTapAction(sender: UITapGestureRecognizer) {
        childrenCount -= 1
        if childrenCount <= 0 {
            childrenCount = 0
        }
        childrenCountLabel.text = "\(childrenCount)"
        countFinalSum()
    }
    
    @IBAction func plusChildrenTapAction(sender: UITapGestureRecognizer) {
        childrenCount += 1
        if childrenCount > 99 {
            childrenCount = 99
        }
        childrenCountLabel.text = "\(childrenCount)"
        countFinalSum()
    }
    
    func countFinalSum() {
        let price = 450
        let childrenPrice = 250
        let sum = price * count + childrenPrice * childrenCount
        finalSumLabel.text = "\(sum) ₽"
    }
}

extension ServiceDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupImageCollection() {
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.register(UINib(nibName: "ServiceDetailCell", bundle: nil), forCellWithReuseIdentifier: "ServiceDetailCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceDetailCell", for: indexPath) as! ServiceDetailCell
        return cell
    }
}
