//
//  ThemeManager.swift
//  test_leboncoin
//
//  Created by Perso on 5/30/23.
//

import UIKit

final class ThemeManager {
    static let shared = ThemeManager()

    let primary: UIColor = .init(red: 25/255, green: 42/255, blue: 86/255, alpha: 1)
    let secondary: UIColor = .init(red: 1, green: 168/255, blue: 1/255, alpha: 1)
    let backgroundColor: UIColor = .white
}
