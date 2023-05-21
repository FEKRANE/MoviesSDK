//
//  Interactor.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation

typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> Void

protocol InteractorProtocol {
    func executeRequest<T: Encodable,U: Decodable>(fromURL urlString: String,
                                                 httpMethod: HttpMethod,
                                                 queryParams: [String: String]?,
                                                 bodyRequest: T?,
                                                 headers: HTTPHeaders,
                                                 encoding: ParameterEncoding,
                                                 completion: @escaping (Result<U, Error>) -> Void)
}


struct SDKInteractor: InteractorProtocol {
    fileprivate var networkProvider: SDKNetworkProvider
    
    init(networkProvider: SDKNetworkProvider = NetworkManager.sharedInstance) {
        self.networkProvider = networkProvider
    }
    
    func executeRequest<T: Encodable, U: Decodable>(
        fromURL url: String,
        httpMethod: HttpMethod,
        queryParams: [String: String]? = nil,
        bodyRequest: T? = nil,
        headers: HTTPHeaders,
        encoding: ParameterEncoding,
        completion: @escaping CompletionHandler<U>
    ) {
        let task = self.networkProvider.buildTask(fromURL: url, httpMethod: httpMethod, queryParams: queryParams, bodyRequest: bodyRequest, headers: headers, encoding: encoding, completion: completion)
        task.resume()
    }
}
