//
//  NetworkController.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Foundation

public protocol NetworkController {
    func request<T: Codable>(for endpoint: Endpoint) async throws -> T
}
