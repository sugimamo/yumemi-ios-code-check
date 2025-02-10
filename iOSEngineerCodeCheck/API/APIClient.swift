//
//  APIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by 杉田守 on 2025/02/10.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol APIClient {
    associatedtype ResponseData
    func load(url: String) async throws -> ResponseData
    func decode(from data: Data) throws -> ResponseData
}

extension APIClient {
    func load(url: String) async throws -> ResponseData {
        guard let url = URL(string: url) else {
            throw APIError.invalidUrl
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.other(message: "Empty HttpResponse")
            }
            guard httpResponse.statusCode == 200 else {
                throw APIError.httpStatus(code: httpResponse.statusCode)
            }
            return try decode(from: data)
        } catch {
            throw APIError.other(message: error.localizedDescription)
        }
    }
}
