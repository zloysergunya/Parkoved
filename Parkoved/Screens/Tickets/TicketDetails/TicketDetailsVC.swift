//
//  TicketDetailsVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import UIKit

class TicketDetailsVC: UIViewController {
    
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
    
    var ticket: Ticket!
    var service: Service!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        serviceName.text = service.name
        workTimeLabel.text = service.workingHours
        ageLimit.text = "\(service.ageLimit)+"
        count.text = "\(ticket.uses)"
        forChildrenView.isHidden = !ticket.isForChild
        useLabel.text = findEndOfWord(ticket.uses)
        ticketView.backgroundColor = ticket.isForChild ? .ticketColorGreen : .ticketColorBlue
        workTimeHeader.textColor = ticket.isForChild ? .ticketTextGreen : .ticketTextBlue
        ageLimitHeader.textColor = ticket.isForChild ? .ticketTextGreen : .ticketTextBlue
        validUntilHeader.textColor = ticket.isForChild ? .ticketTextGreen : .ticketTextBlue
    }
    
    func findEndOfWord(_ num: Int) -> String {
        switch num % 10 {
        case 1:
            return "использованиe"
        case 2, 3, 4:
            return "использования"
        default:
            return "использований"
        }
    }
}
