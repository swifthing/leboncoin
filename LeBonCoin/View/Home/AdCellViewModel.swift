//
//  AdCellViewModel.swift
//  LeBonCoin
//
//  Created by Anis on 18/02/2023.
//

import Foundation
import UIKit

final class AdCellViewModel {
    private let imageCacheManager: ImageCacheManager = ImageCacheManager()

    func getImage (from dataSource: ImageCacheManager.ImageSource) async throws -> UIImage? {
        return try await imageCacheManager.getImage(from: dataSource)
    }
}
