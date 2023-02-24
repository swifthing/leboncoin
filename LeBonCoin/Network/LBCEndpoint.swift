//
//  LBCEndpoint.swift
//  LeBonCoin
//
//  Created by Anis on 18/02/2023.
//

import Foundation

enum LBCEndpoint {
    case classifiedAds
    case categories

    private var fullPath: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "raw.githubusercontent.com"

        switch self {
            case .classifiedAds:
                urlComponents.path = "/leboncoin/paperclip/master/listing.json"
            case .categories:
                urlComponents.path = "/leboncoin/paperclip/master/categories.json"
        }
        return urlComponents
    }

    var request: URLRequest {
        guard let url = fullPath.url else {
            fatalError("Erreur request \(#function)")
        }

        return URLRequest(url: url)
    }
}
