//
//  CategoryTableViewCell.swift
//  Statistics
//
//  Created by Aysel Heydarova on 10.02.23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    private var chartView: PieChart = {
        let chart = PieChart()
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()

    private var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var percentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()

    private var dotLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        label.text = "●"
        label.textColor = .systemOrange
        return label
    }()

    private var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()

    private var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.axis = .horizontal
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with category: Category) {
        categoryNameLabel.text = category.categoryName
        percentLabel.text = "\(category.percent) %"
        amountLabel.text = "\(category.amount) AZN"

        let pieChartItem: PieChartItem = PieChartItem(
            ratio: CGFloat(category.percent),
            color: category.color,
            arcwidth: 3,
            centerImage: category.image
        )
        chartView.setItem(item: pieChartItem)
    }

    private func setup() {
        addSubviews()
        addConstraints()
        selectionStyle = .none
    }

    private func addSubviews() {
        rightStackView.addArrangedSubview(percentLabel)
        rightStackView.addArrangedSubview(dotLabel)
        rightStackView.addArrangedSubview(amountLabel)

        [chartView, categoryNameLabel, rightStackView]
            .forEach(addSubview)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            chartView.widthAnchor.constraint(equalToConstant: 40),
            chartView.heightAnchor.constraint(equalToConstant: 40),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            chartView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            categoryNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryNameLabel.leadingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: 16),

            rightStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
