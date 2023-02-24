//
//  DetailViewController.swift
//  LeBonCoin
//
//  Created by Anis on 23/02/2023.
//

import UIKit

final class DetailViewController: UIViewController {

    let viewModel: DetailViewModel = DetailViewModel()

    let imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: NSLocalizedString("title", comment: ""))
        img.sizeToFit()
        return img
    }()

    var itemAd: ClassifiedAd?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        setupImageView()
    }

    func setupImageView() {
        view.addSubview(imageView)
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 1).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1).isActive = true

        imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 1).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true

        if let img = itemAd?.image, let url = URL(string: img) {
            Task {
                imageView.image = try await viewModel.getImage(from: .remote(url))
            }
        }
    }
}



