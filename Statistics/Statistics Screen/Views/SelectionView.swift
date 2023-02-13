//
//  SelectionView.swift
//  Statistics
//
//  Created by Aysel Heydarova on 13.02.23.
//

import UIKit

struct SelectionViewItem {
    var image: UIImage?
    var title: String
    var description: String?
}

class SelectionView: UIView {
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()

    private var selectionButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(systemName: "chevron.down")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .gray
        button.setImage(buttonImage, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: SelectionViewItem) {
        imageView.image = item.image
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        imageView.isHidden = item.image == nil
    }

    private func setup() {
        addSubviews()
        addConstraints()
        layer.cornerRadius = 8
        self.backgroundColor = .systemBackground
    }

    private func addSubviews() {
        [imageView, titleLabel, descriptionLabel]
            .forEach(stackView.addArrangedSubview)

        [stackView, selectionButton]
            .forEach(addSubview)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 48),
            imageView.heightAnchor.constraint(equalToConstant: 32),

            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            selectionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            selectionButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
