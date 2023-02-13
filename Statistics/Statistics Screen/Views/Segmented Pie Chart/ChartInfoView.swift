//
//  ChartInfoView.swift
//  Statistics
//
//  Created by Aysel Heydarova on 12.02.23.
//

import UIKit

struct InfoItem {
    let title: String
    let amount: CGFloat
    let currency: String
    let isButtonVisible: Bool
}

class ChartInfoView: UIView {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    private var viewStatementButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: InfoItem) {
        titleLabel.text = item.title
        amountLabel.text = "\(item.amount)"
        currencyLabel.text = item.currency
        viewStatementButton.isHidden = !item.isButtonVisible

        let attributedTitle = NSMutableAttributedString(string: "View Statement")
        attributedTitle.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedTitle.length))
        viewStatementButton.setAttributedTitle(attributedTitle, for: .normal)
        viewStatementButton.setTitleColor(.black, for: .normal)
    }

    private func setup() {
        addSubviews()
        addConstraints()
        backgroundColor = .systemBackground
    }

    private func addSubviews() {
        [titleLabel, amountLabel, currencyLabel, viewStatementButton]
            .forEach(mainStackView.addArrangedSubview)
        
        addSubview(mainStackView)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
