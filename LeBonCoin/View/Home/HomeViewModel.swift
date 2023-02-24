//
//  HomeViewModel.swift
//  LeBonCoin
//
//  Created by Anis on 17/02/2023.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var classifiedAds: [ClassifiedAd] = []
    var categoriesList: [Categorie] = []

    var classifiedAdsRepository: ClassifiedAdsRepositoryProtocol
    var categoriesRepository: CategoriesRepositoryProtocol
    var adsCount: Int { classifiedAds.count }

    init (classifiedAdsRepository: ClassifiedAdsRepositoryProtocol = ClassifiedAdsRepository(),
          categoriesRepository: CategoriesRepositoryProtocol = CategoriesRepository()) {
        self.classifiedAdsRepository = classifiedAdsRepository
        self.categoriesRepository = categoriesRepository
        fetchCategories()
        fetchClassifiedAd()
    }

    func fetchClassifiedAd () {
        Task {
            classifiedAds = try await classifiedAdsRepository.fetch()
        }
    }

    private func fetchCategories () {
        Task {
            categoriesList = try await categoriesRepository.fetch()
        }
    }
}
