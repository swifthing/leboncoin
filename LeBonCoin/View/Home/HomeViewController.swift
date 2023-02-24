//
//  HomeViewController.swift
//  LeBonCoin
//
//  Created by Anis on 17/02/2023.
//

import UIKit
import Combine

final class HomeViewController: UITableViewController {

    var viewModel: HomeViewModel = HomeViewModel()
    var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HomeViewTitle".localized
        setupTableView()
        subscribeToViewModel()
    }

    func subscribeToViewModel() {
        cancellable = viewModel.$classifiedAds
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.tableView.reloadData()
            }
    }

    func setupTableView() {
        tableView.register(AdCell.self, forCellReuseIdentifier: AdCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.itemAd = viewModel.classifiedAds[indexPath.row]
        detailVC.categoriesList = viewModel.categoriesList
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.adsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdCell.identifier, for: indexPath) as! AdCell
        cell.setValueForAdCell(adCell: viewModel.classifiedAds[indexPath.row])
        cell.categoriesList = viewModel.categoriesList
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! AdCell
        cell.setImage()
    }

    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! AdCell
        cell.removeImage()
    }
}
