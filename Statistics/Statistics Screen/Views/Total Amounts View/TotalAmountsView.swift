//
//  TotalAmountsView.swift
//  Statistics
//
//  Created by Aysel Heydarova on 13.02.23.
//

import UIKit

struct TotalAmountsItem {
    let totalExpences: String
    let totalIncomes: String
    let totalCashback: String
}

class TotalAmountsView: UIView {
    private var expencesView: TotalAmountView = {
        let view = TotalAmountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var incomingsView: TotalAmountView = {
        let view = TotalAmountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var cashbacksView: TotalAmountView = {
        let view = TotalAmountView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var totalAmountsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: TotalAmountsItem) {
        expencesView.configure(with: .init(totalAmount: item.totalExpences, title: "Expences"))
        incomingsView.configure(with: .init(totalAmount: item.totalIncomes, title: "Incomes"))
        cashbacksView.configure(with: .init(totalAmount: item.totalCashback, title: "Cashbacks"))
    }

    private func setup() {
        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        [expencesView, incomingsView, cashbacksView]
            .forEach(totalAmountsStack.addArrangedSubview)
        addSubview(totalAmountsStack)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            totalAmountsStack.topAnchor.constraint(equalTo: topAnchor),
            totalAmountsStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            totalAmountsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            totalAmountsStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
