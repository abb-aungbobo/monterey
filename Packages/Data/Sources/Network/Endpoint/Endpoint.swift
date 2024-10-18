//
//  Endpoint.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Alamofire

public protocol Endpoint: URLConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
}
