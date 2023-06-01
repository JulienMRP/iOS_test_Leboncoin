//
//  OfferListViewController.swift
//  test_leboncoin
//
//  Created by Perso on 5/30/23.
//

import UIKit

final class OfferListViewController: GenericViewController {
    
    private var viewModel: OfferListViewModel

    private lazy var tableView: UITableView = {
        let _tableView = UITableView()
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.backgroundColor = ThemeManager.shared.backgroundColor
        _tableView.separatorStyle = .none
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.register(OfferCell.self, forCellReuseIdentifier: "offerCell")
        return _tableView
    }()
    
    private lazy var filterContainer: UIControl = {
        let _view = UIControl()
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.backgroundColor = ThemeManager.shared.backgroundColor
        _view.addTarget(self, action: #selector(presentFilter), for: .touchUpInside)
        _view.layer.cornerRadius = 15
        return _view
    }()
    
    private lazy var filterBorder: UIControl = {
        let _view = UIControl()
        _view.translatesAutoresizingMaskIntoConstraints = false
        _view.backgroundColor = ThemeManager.shared.primary
        _view.layer.cornerRadius = 15
        return _view
    }()
    
    private lazy var fixedLabelCategorie: UILabel = {
        let _label = UILabel()
        _label.text = "Catégories: "
        _label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        _label.translatesAutoresizingMaskIntoConstraints = false
        return _label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let _label = UILabel()
        _label.text = "Toutes"
        _label.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        _label.translatesAutoresizingMaskIntoConstraints = false
        return _label
    }()
    
    init(viewModel: OfferListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAutoLayout()
        setupViewModel()
    }
    
    @objc
    private func presentFilter() {
        let filterView = FilterViewController()
        filterView.viewModel = viewModel
        filterView.modalPresentationStyle = .formSheet
        filterView.preferredContentSize = .init(width: 300, height: 500)
        filterView.delegate = self
        navigationController?.present(filterView, animated: true)
    }
    
    private func setupViewModel() {
        viewModel.bindDataToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.updateUI()
            }
        }
    }
    
    
    
    private func updateCategoryUI(id: Int) {
        let category = viewModel.getCategoryNameForId(id: id)
        categoryLabel.text = category
    }
    
    
    
    private func updateUI() {
        self.title = "\(viewModel.numberOfCells) Annonces en ligne"
    }
    
    private func setupAutoLayout() {
        view.addSubview(tableView)
        view.addSubview(filterBorder)
        filterBorder.addSubview(filterContainer)
        filterContainer.addSubview(fixedLabelCategorie)
        filterContainer.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            filterBorder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            filterBorder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            filterContainer.topAnchor.constraint(equalTo: filterBorder.topAnchor, constant: 2),
            filterContainer.bottomAnchor.constraint(equalTo: filterBorder.bottomAnchor, constant: -2),
            filterContainer.trailingAnchor.constraint(equalTo: filterBorder.trailingAnchor, constant: -2),
            filterContainer.leadingAnchor.constraint(equalTo: filterBorder.leadingAnchor, constant: 2),
            
            fixedLabelCategorie.leadingAnchor.constraint(equalTo: filterContainer.leadingAnchor, constant: 18),
            fixedLabelCategorie.topAnchor.constraint(equalTo: filterContainer.topAnchor, constant: 8),
            fixedLabelCategorie.bottomAnchor.constraint(equalTo: filterContainer.bottomAnchor, constant: -8),
            
            categoryLabel.topAnchor.constraint(equalTo: filterContainer.topAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: fixedLabelCategorie.trailingAnchor, constant: 12),
            categoryLabel.bottomAnchor.constraint(equalTo: filterContainer.bottomAnchor, constant: -8),
            categoryLabel.trailingAnchor.constraint(equalTo: filterContainer.trailingAnchor, constant: -18),
            
            tableView.topAnchor.constraint(equalTo: filterBorder.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension OfferListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let offer = viewModel.getCellViewModel(indexPath: indexPath)
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as? OfferCell {
            cell.configure(model: offer)
            return cell
        }
        fatalError("failed to dequeue OfferCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectIndex(index: indexPath)
    }
}

extension OfferListViewController: FilterDelegate{
    func didSelectFilter(id: Int) {
        viewModel.filterData(categoryId: id)
        updateCategoryUI(id: id)
    }
}
