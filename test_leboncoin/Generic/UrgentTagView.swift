//
//  UrgentTagView.swift
//  test_leboncoin
//
//  Created by Perso on 5/30/23.
//

import UIKit

final class UrgentTagView : UIView {
    
    
    
    lazy var containerView: UIView = {
        let _view = UIView()
        _view.backgroundColor = ThemeManager.shared.backgroundColor
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.layer.cornerRadius = 12
        return _view
    }()
    
    lazy var label: UILabel = {
       let _label = UILabel()
        _label.textColor = ThemeManager.shared.secondary
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.textAlignment = .center
        _label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        return _label
    }()
    
    private func configureView() {
        setupAutoLayout()
        label.text = "URGENT"
        backgroundColor = ThemeManager.shared.secondary
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
    }
    
    init() {
        super.init(frame: CGRectZero)
        configureView()
    }
    
    private func setupAutoLayout() {
        addSubview(containerView)
        containerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
