//
//  ClassifiedAdAdapter.swift
//  LeBonCoin
//
//  Created by Anis on 23/02/2023.
//

import Foundation

struct ClassifiedAdAdapter {
    func transform(_ dto: ClassifiedAdDTO) -> ClassifiedAd {
        ClassifiedAd(id: dto.id,
                     category_id: dto.category_id,
                     title: dto.title,
                     description: dto.description,
                     price: dto.price,
                     imageSmall: dto.images_url.small,
                     imageThumb: dto.images_url.thumb,
                     creation_date: dto.creation_date,
                     is_urgent: dto.is_urgent)
    }
}
