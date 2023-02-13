//
//  TotalAmountView.swift
//  Statistics
//
//  Created by Aysel Heydarova on 13.02.23.
//

import UIKit

struct TotalAmountItem {
    let totalAmount: String
    let title: String
}

class TotalAmountView: UIView {
    private var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: TotalAmountItem) {
        titleLabel.text = item.title
        amountLabel.text = item.totalAmount
    }

    private func setup() {
        addSubviews()
        addConstraints()
    }

    private func addSubviews() {
        [amountLabel, titleLabel]
            .forEach(addSubview)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 110),

            amountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            amountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
