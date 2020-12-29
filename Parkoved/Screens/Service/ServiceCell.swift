//
//  ServiceCell.swift
//  Parkoved
//
//  Created by Sergey Kotov on 27.09.2020.
//

import UIKit

class ServiceCell: UITableViewCell {

    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var serviceChildrenPrice: UILabel!
    @IBOutlet weak var ageLimit: UILabel!
    @IBOutlet weak var serviceDiscription: UILabel!
    
    func configCell(with service: Service) {
        serviceImage.downloaded(from: service.imageURL)
        serviceName.text = service.name
        servicePrice.text = "\(service.price) р."
        serviceChildrenPrice.text = "\(service.price - 100) р."
        ageLimit.text = "\(Int.random(in: 100...900)) м. · \(service.ageLimit)+"
        serviceDiscription.text = service.serviceDescription
    }
    
}
