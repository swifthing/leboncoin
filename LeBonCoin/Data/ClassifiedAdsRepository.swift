//
//  ClassifiedAdsRepository.swift
//  LeBonCoin
//
//  Created by Anis on 23/02/2023.
//

import Foundation

protocol ClassifiedAdsRepositoryProtocol {
    func fetch () async throws -> [ClassifiedAd]
}

struct ClassifiedAdsRepository: ClassifiedAdsRepositoryProtocol {
    private var networkr: Networkr
    private var request: URLRequest
    private var adapter: ClassifiedAdAdapter

    init (networkr: Networkr = Networkr(),
          adapter: ClassifiedAdAdapter = ClassifiedAdAdapter(),
          request: URLRequest = LBCEndpoint.classifiedAds.request) {
        self.networkr = networkr
        self.request = request
        self.adapter = adapter
    }

    func fetch () async throws -> [ClassifiedAd] {
        let classifiedAdsDTO: [ClassifiedAdDTO] = try await networkr.fetchData(request)
        return classifiedAdsDTO.map(adapter.transform)
    }
}
