//
//  FilterView.swift
//  test_leboncoin
//
//  Created by Perso on 5/31/23.
//

import UIKit

protocol FilterDelegate {
    func didSelectFilter(id: Int)
}

final class FilterViewController: UIViewController {
    var viewModel: OfferListViewModel!
    var delegate: FilterDelegate!
    private var emptyCategoryFilter = Category(id: -1, name: "Tous")
    private lazy var tableView: UITableView = {
        let _tableView = UITableView()
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.backgroundColor = ThemeManager.shared.backgroundColor
        _tableView.separatorStyle = .none
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.register(FilterCell.self, forCellReuseIdentifier: "filterCell")
        return _tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAutoLayout()
        setupUI()
    }
    
    private func setupUI() {
        title = "test"
    }
    
    private func setupAutoLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.numberOfCategories
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = indexPath.section == 0 ? emptyCategoryFilter : viewModel.getCategoryCellViewModel(indexPath: indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as? FilterCell {
            cell.configure(model: category)
            return cell
        }
        fatalError("failed to dequeue OfferCell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = indexPath.section == 0 ? emptyCategoryFilter : viewModel.getCategoryCellViewModel(indexPath: indexPath)
        delegate.didSelectFilter(id: category.id)
        self.dismiss(animated: true)
    }
}
