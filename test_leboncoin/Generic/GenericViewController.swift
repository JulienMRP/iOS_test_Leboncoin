//
//  GenericViewController.swift
//  test_leboncoin
//
//  Created by Perso on 5/30/23.
//

import UIKit

class GenericViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = ThemeManager.shared.backgroundColor
        setupUI()
    }
    
    private func setupUI() {
        setupNavBar()
        self.title = "Annonces en ligne"
    }
    
    private func setupNavBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.shared.backgroundColor]
        navigationBarAppearance.backgroundColor = ThemeManager.shared.primary
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.isNavigationBarHidden = false
    }
}
