//
//  FilterCell.swift
//  test_leboncoin
//
//  Created by Perso on 5/31/23.
//

import UIKit

final class FilterCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        return _label
    }()
    
    lazy var separator: UIView = {
        let _view = UIView()
        _view.backgroundColor = ThemeManager.shared.primary
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.layer.opacity = 0.3
        return _view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(separator)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configure(model: Category){
        nameLabel.text = model.name
    }
}
