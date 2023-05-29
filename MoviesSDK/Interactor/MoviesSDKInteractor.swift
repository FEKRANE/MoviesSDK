//
//  Interactor.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation

typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> Void

protocol InteractorProtocol {
    func executeRequest<T: Decodable>(fromURL urlString: String,
                                                 httpMethod: HttpMethod,
                                                 queryParams: [String: String]?,
                                                 bodyRequest: Encodable?,
                                                 headers: HTTPHeaders,
                                                 encoding: ParameterEncoding,
                                                 completion: @escaping (Result<T, Error>) -> Void)
}


struct MoviesSDKInteractor: InteractorProtocol {
    
    fileprivate var networkProvider: SDKNetworkProvider
    
    init(networkProvider: SDKNetworkProvider = NetworkManager.sharedInstance) {
        self.networkProvider = networkProvider
    }
    
    func executeRequest<T: Decodable>(
        fromURL url: String,
        httpMethod: HttpMethod,
        queryParams: [String: String]? = nil,
        bodyRequest: Encodable? = nil,
        headers: HTTPHeaders,
        encoding: ParameterEncoding,
        completion: @escaping CompletionHandler<T>
    ) {
        let task = self.networkProvider.buildTask(fromURL: url, httpMethod: httpMethod, queryParams: queryParams, bodyRequest: bodyRequest, headers: headers, encoding: encoding, completion: completion)
        task.resume()
    }
}
