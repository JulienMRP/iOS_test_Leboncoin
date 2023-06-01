//
//  Coordinator.swift
//  test_leboncoin
//
//  Created by Perso on 5/31/23.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
