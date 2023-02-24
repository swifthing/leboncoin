//
//  ClassifiedAd.swift
//  LeBonCoin
//
//  Created by Anis on 18/02/2023.
//

import Foundation

struct ClassifiedAd {
    var id: Int
    var category_id: Int
    var title: String
    var description: String
    var price: Double
    var imageSmall: String?
    var imageThumb: String?

    var image: String? {
        imageSmall ?? imageThumb ?? nil
    }
}
