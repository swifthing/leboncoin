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
    var creation_date: String
    var is_urgent: Bool

    var image: String? {
        imageSmall ?? imageThumb ?? nil
    }

    var creationDate: String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+0000" // 2019-11-05T15:56:55+0000
        let showDate = inputFormatter.date(from: creation_date)
        if let showDate {
            inputFormatter.dateFormat = "dd/MM/yyyy"
            let stringDate = inputFormatter.string(from: showDate)
            return stringDate
        }
        return nil
    }
}
