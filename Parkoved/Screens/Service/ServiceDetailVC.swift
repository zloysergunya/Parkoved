//
//  ServiceDetailVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 27.09.2020.
//

import UIKit
import PassKit

class ServiceDetailVC: UIViewController {

    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var finalSumLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var childrenCountLabel: UILabel!
    @IBOutlet weak var minusButton: UIImageView!
    @IBOutlet weak var plusButton: UIImageView!
    @IBOutlet weak var minusChildrenButton: UIImageView!
    @IBOutlet weak var plusChildrenButton: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var serviceDescription: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var childrenPriceLabel: UILabel!
    
    @IBOutlet weak var serviceShortInfo: UILabel!
    var service: Service!
    var count = 1
    var childrenCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        addTaps()
        countFinalSum()
        setupCollectionView(imageCollection)
        serviceName.text = service.name
        serviceShortInfo.text = "\(Int.random(in: 100...900)) м. · \(service.ageLimit)+ · \(service.workingHours)"
        serviceDescription.text = service.serviceDescription
        priceLable.text = "\(service.price) ₽"
        childrenPriceLabel.text = "\(service.price - 100) ₽"
        
        let set: Set = [1, 2,3]
        var filter = set.fil
    }
    
    private func addTaps() {
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
        if let paymentController = PKPaymentAuthorizationViewController(paymentRequest: createPaymentRequest()) {
            paymentController.delegate = self
            present(paymentController, animated: true)
        }
    }
    
    private func createPaymentRequest() -> PKPaymentRequest {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.ru.krasabs.izba"
        request.supportedNetworks = [.visa, .masterCard]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "RU"
        request.currencyCode = "RUB"
        let amount = NSDecimalNumber(string: finalSumLabel.text)
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Покупка билетов через Парковед", amount: amount)]
        return request
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
    
    private func countFinalSum() {
        let price = service.price
        let childrenPrice = service.price - 100
        let sum = price * count + childrenPrice * childrenCount
        finalSumLabel.text = "\(sum) ₽"
    }
}

// MARK: - work with colletionView
extension ServiceDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ServiceDetailCell", bundle: nil), forCellWithReuseIdentifier: "ServiceDetailCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceDetailCell", for: indexPath) as! ServiceDetailCell
        cell.serviceDetailImageView.downloaded(from: service.imageURL)
        return cell
    }
}

// MARK: - work with paymentVC
extension ServiceDetailVC: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}
