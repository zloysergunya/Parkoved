//
//  ServicesVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 27.09.2020.
//

import UIKit

class ServicesVC: UIViewController {

    @IBOutlet weak var serviceTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupServiceTable()
    }
    
}

extension ServicesVC: UITableViewDataSource, UITableViewDelegate {
    func setupServiceTable() {
        serviceTable.delegate = self
        serviceTable.dataSource = self
        serviceTable.register(UINib(nibName: "ServiceCell", bundle: nil), forCellReuseIdentifier: "ServiceCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        if indexPath.row % 2 == 0 {
            cell.serviceImage.image = UIImage(named: "serviceCircleImage")
            cell.serviceName.text = "“Цед-Зип”"
            cell.ageLimit.text = "200 м · 12+"
            cell.servicePrice.text = "450 ₽"
            cell.serviceChildrenPrice.isHidden = true
            cell.serviceDiscription.text = "Самый первый аттракцион в России. Основан Петром I в 1712 году"
        } else {
            cell.serviceImage.image = UIImage(named: "serviceCarImage")
            cell.serviceName.text = "Машинки"
            cell.ageLimit.text = "950 м · 6+"
            cell.servicePrice.text = "250 ₽"
            cell.serviceChildrenPrice.text = "Десткий: 150 ₽"
            cell.serviceChildrenPrice.isHidden = false
            cell.serviceDiscription.text = "Классический аттракион для всей семьи!"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ServiceDetailVC(nibName: "ServiceDetailVC", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
}
