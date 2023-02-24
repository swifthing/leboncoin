//
//  AdCell.swift
//  LeBonCoin
//
//  Created by Anis on 18/02/2023.
//

import UIKit

final class AdCell: UITableViewCell {

    static let identifier: String = "cell"

    let viewModel: AdCellViewModel
    var categoriesList: [Category] = []
    var adCell: ClassifiedAd!

    private let imgAd: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "imagePlaceholder".localized)
        img.layer.cornerRadius = 4
        img.sizeToFit()
        return img
    }()

    private let titleAd: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        return label
    }()

    private let priceAd: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()

    private let categoryAd: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()

    private let urgentAd: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = .orange
        label.textColor = .white
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        viewModel = AdCellViewModel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    func setValueForAdCell (adCell: ClassifiedAd) {
        self.adCell = adCell
        setupViews()
    }

    private func setupViews () {
        setupImageView()
        setupTitleView()
        setupPriceView()
        setupCategoryView()
        setupUrgentView()
    }

    private func setupImageView () {
        contentView.addSubview(imgAd)
        imgAd.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 1).isActive = true
        imgAd.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -1).isActive = true
        imgAd.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        imgAd.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    func setImage () {
        if let img = adCell.image, let url = URL(string: img) {
            Task {
                imgAd.image = try await viewModel.getImage(from: .remote(url))
            }
        }
    }

    func removeImage () {
        imgAd.image = nil
    }

    private func setupTitleView () {
        contentView.addSubview(titleAd)
        titleAd.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3).isActive = true
        titleAd.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -3).isActive = true
        titleAd.topAnchor.constraint(equalTo: imgAd.bottomAnchor, constant: 5).isActive = true
        titleAd.text = adCell.title
    }

    private func setupPriceView () {
        contentView.addSubview(priceAd)
        priceAd.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3).isActive = true
        priceAd.topAnchor.constraint(equalTo: titleAd.bottomAnchor, constant: 5).isActive = true
        priceAd.text = adCell.price.currency
    }

    private func setupCategoryView () {
        contentView.addSubview(categoryAd)
        categoryAd.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3).isActive = true
        categoryAd.topAnchor.constraint(equalTo: priceAd.bottomAnchor, constant: 5).isActive = true
        categoryAd.text = categoriesList.filter { $0.id == adCell.category_id }.first?.name
    }

    private func setupUrgentView () {
        contentView.addSubview(urgentAd)
        urgentAd.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        urgentAd.topAnchor.constraint(equalTo: categoryAd.bottomAnchor, constant: 5).isActive = true
        urgentAd.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        urgentAd.text = adCell.is_urgent ? "Urgent" : ""
    }
}
