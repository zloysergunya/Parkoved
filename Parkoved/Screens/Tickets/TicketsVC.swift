//
//  TicketsVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit
import RealmSwift

class TicketsVC: FrameVC {

    @IBOutlet weak var ticketsTable: UITableView!
    
    var tickets: Results<Ticket>!
    var services: Results<Service>!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTicketsTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTickets()
        updateServices()
        self.ticketsTable.reloadData()
    }

    @IBAction func addNewTicket(_ sender: Any) {
        bottomBarController.selectedIndex = 1
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

extension TicketsVC {
    @objc func updateInfo() {
        updateTickets()
        updateServices()
        refreshControl.endRefreshing()
    }
    
    func updateServices() {
        let params = ["token": AUTH_TOKEN,
                      "park": "stringstringstri"]
        HTTPRequest(SERVER_URL + "services/", method: "GET", params: params, completion: { data, status in
            if status < 399 {
                if let json = data?.json as? [[String:Any]] {
                    self.saveServices(json)
                }
            }
        })
    }
    
    func saveServices(_ dict: [[String:Any]]) {
        try! realM.write {
            dict.forEach { service in
                realM.add(Service(service), update: .modified)
            }
            self.services = self.realM.objects(Service.self)
            self.ticketsTable.reloadData()
        }
    }
    
    func updateTickets() {
        let params = ["token": AUTH_TOKEN]
        HTTPRequest(SERVER_URL + "tickets/", method: "GET", params: params, completion: { data, status in
            if status < 399 {
                if let json = data?.json as? [[String:Any]] {
                    self.saveTickets(json)
                }
            }
        })
    }
    
    func saveTickets(_ dict: [[String:Any]]) {
        try! realM.write {
            dict.forEach { ticket in
                realM.add(Ticket(ticket), update: .modified)
            }
            self.tickets = self.realM.objects(Ticket.self)
            self.ticketsTable.reloadData()
        }
    }
}

extension TicketsVC: UITableViewDelegate, UITableViewDataSource {
    func setupTicketsTable() {
        refreshControl.addTarget(self, action: #selector(updateInfo), for: .valueChanged)
        refreshControl.tintColor = .black
        refreshControl.alpha = 0.5
        ticketsTable.addSubview(refreshControl)
        ticketsTable.delegate = self
        ticketsTable.dataSource = self
        ticketsTable.register(UINib(nibName: "TicketCell", bundle: nil), forCellReuseIdentifier: "TicketCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketCell
        if let service = realM.objects(Service.self).filter("sid == %@", tickets[indexPath.row].service).first {
            cell.serviceName.text = service.name
            cell.workTimeLabel.text = service.workingHours
            cell.ageLimit.text = "\(service.ageLimit)+"
        }
        cell.count.text = "\(tickets[indexPath.row].uses)"
        cell.forChildrenView.isHidden = !tickets[indexPath.row].isForChild
        cell.useLabel.text = findEndOfWord(tickets[indexPath.row].uses)
        cell.selectionStyle = .none
        cell.ticketView.backgroundColor = tickets[indexPath.row].isForChild ? .ticketColorGreen : .ticketColorBlue
        cell.workTimeHeader.textColor = tickets[indexPath.row].isForChild ? .ticketTextGreen : .ticketTextBlue
        cell.ageLimitHeader.textColor = tickets[indexPath.row].isForChild ? .ticketTextGreen : .ticketTextBlue
        cell.validUntilHeader.textColor = tickets[indexPath.row].isForChild ? .ticketTextGreen : .ticketTextBlue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TicketDetailsVC(nibName: "TicketDetailsVC", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
}
