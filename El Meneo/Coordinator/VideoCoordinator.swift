//
//  VideoCoordinator.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 10/12/21.
//

import UIKit

class VideoCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = VideosController()
        vc.navigationItem.title = "Videos"
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = UITabBarItem(title: "Videos", image: UIImage(systemName: "play.rectangle.fill"), tag: 1)
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}
