//
//  ClassifiedAdDTO.swift
//  LeBonCoin
//
//  Created by Anis on 23/02/2023.
//

import Foundation

struct ClassifiedAdDTO: Codable, Equatable {
    var id: Int
    var category_id: Int
    var title: String
    var description: String
    var price: Double
    var images_url: ImagesUrl

    struct ImagesUrl: Codable {
        var small: String?
        var thumb: String?
    }

    static func == (lhs: ClassifiedAdDTO, rhs: ClassifiedAdDTO) -> Bool {
        lhs.id == rhs.id
    }
}
