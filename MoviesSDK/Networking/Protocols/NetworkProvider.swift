//
//  NetworkProvider.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation

typealias HTTPHeaders = [String: String]

protocol SDKNetworkProvider {
    
    func buildTask<T: Decodable>(fromURL urlString: String,
                                            httpMethod: HttpMethod,
                                            queryParams: [String: String]?,
                                            bodyRequest: Encodable?,
                                            headers: HTTPHeaders,
                                            encoding: ParameterEncoding,
                                            completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTaskProtocol
}
