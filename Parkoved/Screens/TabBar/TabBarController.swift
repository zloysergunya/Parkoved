//
//  TabBarController.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit

var bottomBarController: TabBarController!

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomBarController = self
        title = "СОЧИ ПАРК"
        createTabBarController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func createTabBarController() {        
        let eventsVC = EventsVC(nibName: "EventsVC", bundle: nil)
        eventsVC.tabBarItem = UITabBarItem.init(title: "События", image: UIImage.init(systemName: "calendar"), tag: 0)
        let mapVC = MapVC(nibName: "MapVC", bundle: nil)
        mapVC.tabBarItem = UITabBarItem.init(title: "Карта", image: UIImage.init(systemName: "map"), tag: 0)
        let ticketsVC = TicketsVC(nibName: "TicketsVC", bundle: nil)
        ticketsVC.tabBarItem = UITabBarItem.init(title: "Билеты", image: UIImage.init(systemName: "doc.text.viewfinder"), tag: 0)
        let profileVC = ProfileVC(nibName: "ProfileVC", bundle: nil)
        profileVC.tabBarItem = UITabBarItem.init(title: "Профиль", image: UIImage.init(systemName: "person"), tag: 0)
        
        viewControllers = [eventsVC, mapVC, ticketsVC, profileVC]
    }
}
