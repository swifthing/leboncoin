//
//  CategoriesRepository.swift
//  LeBonCoin
//
//  Created by Anis on 24/02/2023.
//

import Foundation

protocol CategoriesRepositoryProtocol {
    func fetch () async throws -> [Category]
}

struct CategoriesRepository: CategoriesRepositoryProtocol {

    private var networkr: Networkr
    private var request: URLRequest
    private var adapter: CategoriesdAdapter = CategoriesdAdapter()

    init (network: Networkr = Networkr(), adapter: CategoriesdAdapter = CategoriesdAdapter(), request: URLRequest = LBCEndpoint.categories.request) {
        self.networkr = Networkr()
        self.request = request
        self.adapter = adapter
    }

    func fetch () async throws -> [Category] {
        let categoriesDTO: [CategoryDTO] = try await networkr.fetchData(request)
        return categoriesDTO.map(adapter.transform)
    }
}
