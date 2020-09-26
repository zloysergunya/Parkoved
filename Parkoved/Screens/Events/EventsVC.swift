//
//  EventsVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit

class EventsVC: FrameVC {

    @IBOutlet weak var eventsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEventsTable()
    }
    
}

extension EventsVC: UITableViewDelegate, UITableViewDataSource {
    func setupEventsTable() {
        eventsTable.delegate = self
        eventsTable.dataSource = self
        eventsTable.register(UINib(nibName: "EventHeaderCell", bundle: nil), forCellReuseIdentifier: "EventHeaderCell")
        eventsTable.register(UINib(nibName: "EventNewsCell", bundle: nil), forCellReuseIdentifier: "EventNewsCell")
        eventsTable.register(UINib(nibName: "ArticlesCollectionCell", bundle: nil), forCellReuseIdentifier: "ArticlesCollectionCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventHeaderCell") as! EventHeaderCell
        switch section {
        case 0:
            cell.headerTitleLabel.text = "Для вас"
        default:
            cell.headerTitleLabel.text = "Новости и объявления"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesCollectionCell", for: indexPath) as! ArticlesCollectionCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventNewsCell", for: indexPath) as! EventNewsCell
            return cell
        }
    }
    
    
}
