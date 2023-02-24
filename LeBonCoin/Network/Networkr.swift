//
//  Networkr.swift
//  LeBonCoin
//
//  Created by Anis on 18/02/2023.
//

import Foundation
import Combine

final class Networkr: ObservableObject {
    func fetchData<Response:Codable>(_ request: URLRequest) async throws -> Response {
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
