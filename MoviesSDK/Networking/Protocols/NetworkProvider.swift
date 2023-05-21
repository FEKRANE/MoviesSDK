//
//  NetworkProvider.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation

typealias HTTPHeaders = [String: String]

protocol SDKNetworkProvider {
    
    func buildTask<T: Encodable,U: Decodable>(fromURL urlString: String,
                                            httpMethod: HttpMethod,
                                            queryParams: [String: String]?,
                                            bodyRequest: T?,
                                            headers: HTTPHeaders,
                                            encoding: ParameterEncoding,
                                            completion: @escaping (Result<U, Error>) -> Void) -> URLSessionTaskProtocol
}
