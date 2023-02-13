//
//  TotalStatisticsView.swift
//  Statistics
//
//  Created by Aysel Heydarova on 13.02.23.
//

import UIKit

struct TotalStatisticsItem {
    var totalExpences: String
    var totalIncomes: String
    var totalCashback: String
    var chartEntries: [PieChartDataEntry]
}

class TotalStatisticsView: UIView {
    private var totalAmountsView: TotalAmountsView = {
        let totalAmountsView = TotalAmountsView()
        totalAmountsView.translatesAutoresizingMaskIntoConstraints = false
        return totalAmountsView
    }()

    private let chart: SegmentedPieChart = {
        let chart = SegmentedPieChart()
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: TotalStatisticsItem) {
        totalAmountsView.configure(with: .init(
            totalExpences: item.totalExpences,
            totalIncomes: item.totalIncomes,
            totalCashback: item.totalCashback
        ))
        chart.dataEntries = item.chartEntries
    }

    private func setup() {
        addSubviews()
        addConstraints()
        backgroundColor = .systemBackground
        chart.backgroundColor = .systemBackground
    }

    private func addSubviews() {
        [totalAmountsView, chart]
            .forEach(addSubview)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            totalAmountsView.topAnchor.constraint(equalTo: topAnchor),
            totalAmountsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            totalAmountsView.trailingAnchor.constraint(equalTo: trailingAnchor),

            chart.topAnchor.constraint(equalTo: totalAmountsView.bottomAnchor),
            chart.leadingAnchor.constraint(equalTo: leadingAnchor),
            chart.trailingAnchor.constraint(equalTo: trailingAnchor),
            chart.heightAnchor.constraint(equalToConstant: 300),
            chart.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
