//
//  TicketsVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit

class TicketsVC: FrameVC {

    @IBOutlet weak var ticketsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTicketsTable()
    }

    @IBAction func addNewTicket(_ sender: Any) {
        bottomBarController.selectedIndex = 1
    }
}

extension TicketsVC: UITableViewDelegate, UITableViewDataSource {
    func setupTicketsTable() {
        ticketsTable.delegate = self
        ticketsTable.dataSource = self
        ticketsTable.register(UINib(nibName: "TicketCell", bundle: nil), forCellReuseIdentifier: "TicketCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketCell
        cell.selectionStyle = .none
        cell.ageLimitHeader.textColor = .ticketTextGreen
        cell.workTimeHeader.textColor = .ticketTextGreen
        cell.validUntilHeader.textColor = .ticketTextGreen
        cell.ticketView.backgroundColor = .ticketColorGreen
        switch indexPath.row {
        case 0:
            cell.serviceName.text = "Карусель"
            cell.validUntilLabel.text = "25/10/2020"
            cell.workTimeLabel.text = "10:00-20:00"
            cell.ageLimit.text = "0+"
        case 1:
            cell.serviceName.text = "Зона отдыха"
            cell.validUntilLabel.text = "21/11/2020"
            cell.workTimeLabel.text = "10:00-20:00"
            cell.ageLimit.text = "12+"
            cell.ageLimitHeader.textColor = .ticketTextBlue
            cell.workTimeHeader.textColor = .ticketTextBlue
            cell.validUntilHeader.textColor = .ticketTextBlue
            cell.ticketView.backgroundColor = .ticketColorBlue
        case 2:
            cell.serviceName.text = "Колесо обозрения"
            cell.validUntilLabel.text = "01/11/2020"
            cell.workTimeLabel.text = "10:00-20:00"
            cell.ageLimit.text = "6+"
            cell.ageLimitHeader.textColor = .ticketTextBlue
            cell.workTimeHeader.textColor = .ticketTextBlue
            cell.validUntilHeader.textColor = .ticketTextBlue
            cell.ticketView.backgroundColor = .ticketColorBlue
        default:
            cell.serviceName.text = "Лошадки"
            cell.validUntilLabel.text = "05/10/2020"
            cell.workTimeLabel.text = "10:00-20:00"
            cell.ageLimit.text = "3+"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TicketDetailsVC(nibName: "TicketDetailsVC", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
}
