//
//  TabBarController.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit
import OverlayContainer

var bottomBarController: TabBarController!

class TabBarController: UITabBarController, OverlayContainerViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomBarController = self
        hideKeyboardWhenTappedAround()
        title = "ЦЕНТРАЛЬНЫЙ ПАРК"
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
        let serviceVC = ServicesVC(nibName: "ServicesVC", bundle: nil)
        let mapContainer = OverlayContainerViewController(style: .rigid)
        mapContainer.delegate = self
        mapContainer.viewControllers = [mapVC, serviceVC]
        mapContainer.moveOverlay(toNotchAt: 0, animated: true)
        mapContainer.tabBarItem = UITabBarItem.init(title: "Карта", image: UIImage.init(systemName: "map"), tag: 0)
        let ticketsVC = TicketsVC(nibName: "TicketsVC", bundle: nil)
        ticketsVC.tabBarItem = UITabBarItem.init(title: "Билеты", image: UIImage.init(systemName: "doc.text.viewfinder"), tag: 0)
        let profileVC = ProfileVC(nibName: "ProfileVC", bundle: nil)
        profileVC.tabBarItem = UITabBarItem.init(title: "Профиль", image: UIImage.init(systemName: "person"), tag: 0)
        
        viewControllers = [eventsVC, mapContainer, ticketsVC, profileVC]
    }
    
    enum OverlayNotch: Int, CaseIterable {
        case minimum, maximum
    }

    func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
        return OverlayNotch.allCases.count
    }

    func overlayContainerViewController(_ containerViewController: OverlayContainerViewController,
                                        heightForNotchAt index: Int,
                                        availableSpace: CGFloat) -> CGFloat {
        switch OverlayNotch.allCases[index] {
            case .maximum:
                return availableSpace * 0.80
            case .minimum:
                return availableSpace * 0.25
        }
    }
}
