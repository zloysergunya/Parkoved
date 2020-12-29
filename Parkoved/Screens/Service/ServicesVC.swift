//
//  ServicesVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 27.09.2020.
//

import UIKit
import RealmSwift

class ServicesVC: UIViewController {

    @IBOutlet weak var serviceTable: UITableView!
    
    var services: Results<Service>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTableView(serviceTable)
        let ticketsDataProvider = TicketsDataProvider()
        services = ticketsDataProvider.getServices()
    }
}

extension ServicesVC: UITableViewDataSource, UITableViewDelegate {
    private func setupTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellReuseIdentifier: "ServiceCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        cell.configCell(with: services[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ServiceDetailVC(nibName: "ServiceDetailVC", bundle: nil)
        vc.service = services[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}
