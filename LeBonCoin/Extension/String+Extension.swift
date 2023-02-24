//
//  String+Extension.swift
//  LeBonCoin
//
//  Created by Anis on 24/02/2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
