//
//  OfferDetailViewController.swift
//  test_leboncoin
//
//  Created by Perso on 5/31/23.
//

import UIKit

final class OfferDetailViewController: GenericViewController {
    
    private var viewModel: OfferDetailViewModel
    
    private lazy var scrollView: UIScrollView = {
       let _scrollView = UIScrollView()
        _scrollView.translatesAutoresizingMaskIntoConstraints = false
        _scrollView.backgroundColor = .clear
        return _scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let _image = UIImageView()
        _image.translatesAutoresizingMaskIntoConstraints = false
        _image.contentMode = .scaleAspectFit
        return _image
    }()
    
    lazy var separator: UIView = {
        let _view = UIView()
        _view.backgroundColor = ThemeManager.shared.primary
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.layer.opacity = 0.3
        return _view
    }()
    
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
    
    lazy var siretLabel: UILabel = {
        let _label = UILabel()
        _label.numberOfLines = 1
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        return _label
    }()
    
    lazy var dateLabel: UILabel = {
        let _label = UILabel()
        _label.numberOfLines = 1
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        return _label
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
    
    lazy var priceCategStackView: UIStackView = {
        let _stackView = UIStackView(arrangedSubviews: [priceLabel, categoryLabel])
        _stackView.spacing = 10
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        return _stackView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let _label = UILabel()
        _label.numberOfLines = 0
        _label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        return _label
    }()
    
    lazy var informationStackView: UIStackView = {
        let _stackView = UIStackView(arrangedSubviews: [separator, dateLabel, urgentView, siretLabel, priceCategStackView, titleLabel, descriptionLabel])
        _stackView.axis = .vertical
        _stackView.spacing = 10
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        return _stackView
    }()
    
    init(viewModel: OfferDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        setupData()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(informationStackView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -12),
            
            informationStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            informationStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor , constant: 12),
            informationStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -12),
            informationStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -24),
            
            separator.heightAnchor.constraint(equalToConstant: 1),
            informationStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24)
        ])
    }
    
    private func setupData() {
        let offer = viewModel.getData()
        titleLabel.text = offer.title
        priceLabel.text = "\(offer.price) €"
        categoryLabel.text = offer.categoryName
        dateLabel.text = "Offre postée le \(offer.creationDate.dateToFormattedString())"
        siretLabel.text = offer.siret
        if let imgUrl = offer.imagesUrl.thumb {
            imageView.downloadFromUrl(from: imgUrl)
        } else {
            imageView.image = UIImage(named: "question-mark")
        }
        descriptionLabel.text = offer.description
        descriptionLabel.textAlignment = .justified
    }
    
}
