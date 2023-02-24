//
//  CategoriesAdapter.swift
//  LeBonCoin
//
//  Created by Anis on 24/02/2023.
//

import Foundation

struct CategoriesdAdapter {
    func transform(_ dto: CategoryDTO) -> Category {
        Category(id: dto.id,
                  name: dto.name)
    }
}
