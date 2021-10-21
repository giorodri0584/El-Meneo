//
//  Coordinator.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 9/28/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
