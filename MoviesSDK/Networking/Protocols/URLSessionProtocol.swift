//
//  URLSessionProtocol.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func makeDataTask(
        with request: URLRequest,
        completionHandler:
        @escaping DataTaskResult)
    -> URLSessionTaskProtocol
}

extension URLSessionTask: URLSessionTaskProtocol { }

extension URLSession: URLSessionProtocol {
    func makeDataTask(
        with request: URLRequest,
        completionHandler:
        @escaping (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionTaskProtocol {
        return dataTask(with: request,
                        completionHandler: completionHandler)
    }
}

protocol URLSessionTaskProtocol: AnyObject {
  func resume()
}
