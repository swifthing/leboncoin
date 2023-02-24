//
//  ImageCacheManager.swift
//  LeBonCoin
//
//  Created by Anis on 24/02/2023.
//

import UIKit

class ImageCacheManager {

    enum ImageSource {
        case asset (_ named: String)
        case remote (_ url: URL, placeholder: String? = nil)
    }

    let imageCache = NSCache<NSString, NSData>()

    func loadImageWithURL(_ url: URL) async throws -> UIImage? {
        if let cacheData = imageCache.object(forKey: url.absoluteString as NSString) as? Data {
           return UIImage(data: cacheData)
        }

        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        let image = UIImage(data: data)
        imageCache.setObject(data as NSData, forKey: url.absoluteString as NSString)
        return image
    }

    func getImage(from dataSource: ImageSource) async throws -> UIImage? {
        switch dataSource {
            case .asset (let named):
                return UIImage(named: named)
            case let .remote (url, placeholder):
                if let image = try await loadImageWithURL(url) {
                    return image
                }
                if let placeholder {
                    return UIImage(named: placeholder)
                }
        }
        return nil
    }
}
