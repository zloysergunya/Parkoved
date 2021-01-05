//
//  TicketsVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit
import RealmSwift

class TicketsVC: UIViewController {

    @IBOutlet weak var ticketsTable: UITableView!
    
    var dataProvider = TicketsDataProvider()
    var tickets: Results<Ticket>!
    var services: Results<Service>!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    @IBAction func addNewTicket(_ sender: Any) {
        bottomBarController.selectedIndex = 1
    }
    
    private func setupUI() {
        setupTableView(ticketsTable)
    }
    
    private func updateUI() {
        dataProvider.updateServices() { [weak self] in
            guard let self = self else { return }
            self.services = self.dataProvider.getServices()
        }
        
        dataProvider.updateTickets() { [weak self] in
            guard let self = self else { return }
            self.tickets = self.dataProvider.getTickets()
            self.ticketsTable.reloadData()
        }
    }
    
    @objc private func updateInfo() {
        updateUI()
        refreshControl.endRefreshing()
    }
    
    private func findEndOfWord(_ num: Int) -> String {
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

// MARK: - work with tableView
extension TicketsVC: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView(_ tableView: UITableView) {
        refreshControl.addTarget(self, action: #selector(updateInfo), for: .valueChanged)
        refreshControl.tintColor = .black
        refreshControl.alpha = 0.5
        tableView.addSubview(refreshControl)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TicketCell", bundle: nil), forCellReuseIdentifier: "TicketCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketCell
        if let service = dataProvider.getServiceById(tickets[indexPath.row].service) {
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
        vc.ticket = tickets[indexPath.row]
        vc.service = Service()
        if let service = dataProvider.getServiceById(tickets[indexPath.row].service) {
            vc.service = service
        }
        self.present(vc, animated: true, completion: nil)
    }
}
