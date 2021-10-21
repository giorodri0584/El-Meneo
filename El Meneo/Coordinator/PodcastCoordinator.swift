//
//  PodcastCoordinator.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 10/13/21.
//

import UIKit
import SwiftUI

class PodcastCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = PodcastViewController()
        vc.navigationItem.title = "Podcasts"
        vc.coordinator = self
        vc.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = UITabBarItem(title: "Podcasts", image: UIImage(systemName: "mic"), tag: 3)
        navigationController.pushViewController(vc, animated: false)
    }
    func navigatePodcastDetail(postcast:Podcast) {
        let vc = UIHostingController(rootView: PodcastDetailView(podcast: postcast))
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
