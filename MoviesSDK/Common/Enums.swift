//
//  Enums.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation

enum HttpMethod: String {
    case get
    case post
    var method: String { rawValue.uppercased() }
}

enum ParameterEncoding {
    case URLEncoding
    case JSONEncoding
}

enum ManagerErrors: Error {
    case invalidResponse
    case invalidStatusCode(Int)
}

enum MediaType: String {
    case movie
    case tvSeries
}

/**
    StandardSDKError is an enumeration of possible errors that can be thrown when using the SDK.

    - Case serverCommunication: An error occurred while communicating with the server.
    - Case missingData: A required piece of data was missing from the server response.
    - Case unexpected: An unexpected error occurred with the provided error code.
*/
public enum MoviesSDKError: Error {
    case noSetup
    case serverCommunication
    case missingData
    case unexpected(code: Int)
}

extension MoviesSDKError{
    public var description: String {
        switch self{
        case .noSetup:
            return "You must initialize SDK with the app id."
        case .serverCommunication:
            return "There was an error communicating with the server."
        case .missingData:
            return "There was a missing data from the server call."
        case .unexpected(_):
            return "An unexpected error occurred."
        }
    }
}
