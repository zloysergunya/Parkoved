//
//  TicketCell.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit

class TicketCell: UITableViewCell {

    @IBOutlet weak var ticketView: CornerView!
    @IBOutlet weak var forChildrenView: CornerView!
    @IBOutlet weak var validUntilLabel: UILabel!
    @IBOutlet weak var validUntilHeader: UILabel!
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var workTimeHeader: UILabel!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var ageLimit: UILabel!
    @IBOutlet weak var ageLimitHeader: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var useLabel: UILabel!
    
}
