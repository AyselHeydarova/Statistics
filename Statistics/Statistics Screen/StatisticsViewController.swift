//
//  StatisticsViewController.swift
//  Statistics
//
//  Created by Aysel Heydarova on 10.02.23.
//

import UIKit

class StatisticsViewController: UIViewController {
    private var viewModel: StatisticsViewModel = StatisticsViewModel()

    private var cardSelection: SelectionView = {
        let view = SelectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var yearSelection: SelectionView = {
        let view = SelectionView()
        return view
    }()

    private var monthSelection: SelectionView = {
        let view = SelectionView()
        return view
    }()

    private var dateSelectionStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let totalStaticsView: TotalStatisticsView = {
        let statisticsView = TotalStatisticsView()
        statisticsView.translatesAutoresizingMaskIntoConstraints = false
        return statisticsView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        addSubviews()
        addConstraints()
        tableView.dataSource = self
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        view.backgroundColor = .systemGroupedBackground
        bottomView.backgroundColor = .systemBackground
        bottomView.layer.cornerRadius = 24

        cardSelection.configure(with: .init(
            image: UIImage(named: "card"), title: "Expresso MC", description: "** 4554"
        ))

        yearSelection.configure(with: .init(
            title: "2023"
        ))

        monthSelection.configure(with: .init(
            title: "February"
        ))

        totalStaticsView.configure(with: .init(
            totalExpences: "1 300 000",
            totalIncomes: "1 700 000",
            totalCashback: "100 500",
            chartEntries: viewModel.chartEntries
        ))

        title = "Stats"
        titleLabel.text = "Categories"
    }

    private func addSubviews() {
        [yearSelection, monthSelection]
            .forEach(dateSelectionStack.addArrangedSubview)
        
        [totalStaticsView, titleLabel, tableView]
            .forEach(bottomView.addSubview)

        [cardSelection, dateSelectionStack, bottomView]
            .forEach(view.addSubview)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            cardSelection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cardSelection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardSelection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            dateSelectionStack.topAnchor.constraint(equalTo: cardSelection.bottomAnchor, constant: 16),

            dateSelectionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateSelectionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            bottomView.topAnchor.constraint(equalTo: dateSelectionStack.bottomAnchor, constant: 16),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            totalStaticsView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16),
            totalStaticsView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            totalStaticsView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: totalStaticsView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
        ])
    }
}

extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell
        guard let cell = cell else { return UITableViewCell() }

        let category = viewModel.categories[indexPath.row]
        cell.configure(with: category)
        return cell
    }
}
