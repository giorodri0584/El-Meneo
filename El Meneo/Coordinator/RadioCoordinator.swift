//
//  MainCoordinator.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 9/28/21.
//

import UIKit

class RadioCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = RadioStationController()
        vc.navigationItem.title = "Radio"
        navigationController.tabBarItem = UITabBarItem(title: "Radio", image: UIImage(systemName: "antenna.radiowaves.left.and.right"), tag: 0)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}
