//
//  NetworkManager.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation


class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    private var session: URLSessionProtocol!
    private var responseQueue: DispatchQueue?
    
    
    init(session: URLSessionProtocol? = nil, responseQueue: DispatchQueue? = .main) {
        self.responseQueue = responseQueue
        
        if let session = session {
            self.session = session
        }else{
            self.session = initializeSession()
        }
    }
    
    private func initializeSession()-> URLSessionProtocol {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 720
        configuration.timeoutIntervalForResource = 720
        let session = URLSession(configuration: configuration,delegate: nil,delegateQueue: nil)
        return session
    }
    
    
    func request<T: Decodable>(fromURL urlString: String,
                                            httpMethod: HttpMethod,
                                            queryParams: [String: String]?,
                                            bodyRequest: Encodable?,
                                            headers: HTTPHeaders,
                                            encoding: ParameterEncoding = .JSONEncoding,
                                            completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTaskProtocol {
        
        let completionOnQueue: (Result<T, Error>) -> Void = { result in
            guard let responseQueue = self.responseQueue else {
                completion(result)
                return
            }
            responseQueue.async {
                completion(result)
            }
        }
        
        var request = prepareUrlRequest(url: urlString, queryParams: queryParams)
        
        headers.forEach({
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        })
        
        request.httpMethod = httpMethod.method
        
        if let bodyRequest = bodyRequest, let requestData = parseHttpBody(params: bodyRequest, encoding: encoding) {
            request.httpBody = requestData
        }
        
        let dataTask = self.session.makeDataTask(with: request) { data, response, error in
            if let error = error {
                completionOnQueue(.failure(error))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else { return completionOnQueue(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnQueue(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }
            
            guard let data = data else { return }
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completionOnQueue(.success(decodedResponse))
            } catch {
                completionOnQueue(.failure(error))
            }
        }
        
        return dataTask
    }
}

extension NetworkManager: SDKNetworkProvider {
    func buildTask<T>(fromURL urlString: String, httpMethod: HttpMethod, queryParams: [String : String]?, bodyRequest: Encodable?, headers: HTTPHeaders, encoding: ParameterEncoding, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTaskProtocol where T : Decodable {
        self.request(fromURL: urlString, httpMethod: httpMethod, queryParams: queryParams, bodyRequest: bodyRequest, headers: headers, encoding: encoding, completion: completion)
    }
}

extension NetworkManager {
    private func prepareUrlRequest(url: String, queryParams: [String: String]?)-> URLRequest{
        var urlComponents = URLComponents(string: url)!
        
        if let queryParams = queryParams{
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in queryParams{
                urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
            }
        }
        
        return URLRequest(url: urlComponents.url!)
    }
    
    private func parseHttpBody<T: Encodable>(params:T,encoding: ParameterEncoding) -> Data? {
        switch encoding {
        case .URLEncoding:
            let urlEncoded = params.dictionary?.dictionaryQueryString()
            return urlEncoded?.data(using: .utf8)
        case .JSONEncoding:
            return try? JSONEncoder().encode(params)
        }
    }
}

