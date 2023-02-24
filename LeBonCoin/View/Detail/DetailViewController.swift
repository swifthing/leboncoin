//
//  DetailViewController.swift
//  LeBonCoin
//
//  Created by Anis on 23/02/2023.
//

import UIKit

final class DetailViewController: UIViewController {

    let viewModel: DetailViewModel = DetailViewModel()

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        return view
    }()

    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imgAd: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "imagePlaceholder".localized)
        img.layer.cornerRadius = 4
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

    private let dateAd: UILabel = {
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
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = .orange
        label.textColor = .white
        return label
    }()

    private let descriptionAd: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    var itemAd: ClassifiedAd?
    var categoriesList: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews () {
        view.backgroundColor = .white
        setupScrollView()
        setupContainerView()
        setupImageView()
        setupTitleView()
        setupPriceView()
        setupCategoryView()
        setupDateView()
        setupUrgentView()
        setupDescriptionView()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
    }

    private func setupContainerView() {
        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        scrollStackViewContainer.addArrangedSubview(imgAd)
        scrollStackViewContainer.addArrangedSubview(titleAd)
        scrollStackViewContainer.addArrangedSubview(priceAd)
        scrollStackViewContainer.addArrangedSubview(categoryAd)
        scrollStackViewContainer.addArrangedSubview(dateAd)
        scrollStackViewContainer.addArrangedSubview(urgentAd)
        scrollStackViewContainer.addArrangedSubview(descriptionAd)
    }

    private func setupImageView () {
        if let img = itemAd?.image, let url = URL(string: img) {
            Task {
                imgAd.image = try await viewModel.getImage(from: .remote(url))
            }
        }
        imgAd.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func setupTitleView () {
        titleAd.text = itemAd?.title
    }

    private func setupPriceView () {
        priceAd.text = itemAd?.price.currency
    }

    private func setupCategoryView () {
        if let categorie = (categoriesList.filter { $0.id == itemAd?.category_id }.first?.name) {
            categoryAd.text = "Catégorie: " + categorie
        }
    }

    private func setupDateView () {
        if let date = itemAd?.creationDate {
            dateAd.text = "Publiée le " + date
        }
    }

    private func setupUrgentView () {
        if let urgent = itemAd?.is_urgent {
            urgentAd.text = urgent ? "Urgent" : ""
        }
    }

    private func setupDescriptionView () {
        descriptionAd.text = itemAd?.description
    }
}



