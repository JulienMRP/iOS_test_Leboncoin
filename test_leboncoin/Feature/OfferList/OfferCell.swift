//
//  OfferCell.swift
//  test_leboncoin
//
//  Created by Perso on 5/30/23.
//

import UIKit

class OfferCell: UITableViewCell {
    
    lazy var urgentView: UIView = {
        let _view = UIView()
        let _urgentTag = UrgentTagView()
        _view.addSubview(_urgentTag)
        NSLayoutConstraint.activate([
            _urgentTag.leadingAnchor.constraint(equalTo: _view.leadingAnchor),
            _urgentTag.topAnchor.constraint(equalTo: _view.topAnchor),
            _urgentTag.bottomAnchor.constraint(equalTo: _view.bottomAnchor),
            _urgentTag.trailingAnchor.constraint(lessThanOrEqualTo: _view.trailingAnchor)
        ])
        return _view
    }()
    
    lazy var image: UIImageView = {
        let _imageView = UIImageView()
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        _imageView.contentMode = .scaleAspectFit
        _imageView.image = UIImage(named: "loading")
        return _imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let _label = UILabel()
        _label.numberOfLines = 2
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        return _label
    }()
    
    lazy var priceLabel: UILabel = {
        let _label = UILabel()
        _label.numberOfLines = 1
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        _label.textColor = ThemeManager.shared.secondary
        return _label
    }()
    
    lazy var categoryLabel: UILabel = {
        let _label = UILabel()
        _label.numberOfLines = 1
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = UIFont(name: "AvenirNext-Regular", size: 12)

        return _label
    }()
    
    lazy var informationStackView: UIStackView = {
        let _stackView = UIStackView(arrangedSubviews: [urgentView, titleLabel, priceLabel, categoryLabel])
        _stackView.axis = .vertical
        _stackView.spacing = 10
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        return _stackView
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
        self.backgroundColor = .green
        setupAutoLayout()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = ThemeManager.shared.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        contentView.addSubview(image)
        contentView.addSubview(informationStackView)
        contentView.addSubview(separator)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 0),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            image.trailingAnchor.constraint(equalTo: informationStackView.leadingAnchor, constant: -12),
            informationStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            informationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            informationStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: informationStackView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configure(model: Offer) {
        titleLabel.text = model.title
        priceLabel.text = "\(model.price) €"
        categoryLabel.text = model.categoryName
        if let imgUrl = model.imagesUrl.thumb {
            image.downloadFromUrl(from: imgUrl)
        } else {
            image.image = UIImage(named: "question-mark")
        }
        if !model.isUrgent {
            urgentView.removeFromSuperview()
        }
    }
}
