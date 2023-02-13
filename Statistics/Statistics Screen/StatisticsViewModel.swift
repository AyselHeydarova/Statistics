//
//  StatisticsViewModel.swift
//  Statistics
//
//  Created by Aysel Heydarova on 10.02.23.
//

import UIKit

class StatisticsViewModel {
    var categories: [Category] = [
        Category(color: .red, image: UIImage(named: "clothes"), categoryName: "Clothes", percent: 14, amount: 1500),
        Category(color: .blue, image: UIImage(named: "transfers"), categoryName: "Bank Transfers", percent: 32, amount: 3500),
        Category(color: .orange, image: UIImage(named: "others"), categoryName: "Others", percent: 18, amount: 2000),
        Category(color: .green, image: UIImage(named: "shopping"), categoryName: "Shopping", percent: 36, amount: 4000)
    ]

    var chartEntries: [PieChartDataEntry] {
        categories.map { category in
            PieChartDataEntry(
                color: category.color,
                value: category.amount,
                categoryName: category.categoryName + " \(category.percent)%"
            )
        }
    }
}

struct Category {
    let color: UIColor
    let image: UIImage?
    let categoryName: String
    let percent: Int
    let amount: CGFloat
}
