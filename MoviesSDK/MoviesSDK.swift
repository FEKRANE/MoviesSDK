//
//  MoviesSDK.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation

struct ApiConfiguration {
    var appid: String
}

///this class is responsible for providing access to the library .
public class MoviesSDK {
    
    /// Shared instance to library
    public static let shared = MoviesSDK()
    private let presenter: MoviesSDKPresenter
    private var configuration: ApiConfiguration?
    
    private init() {
        self.presenter = MoviesSDKPresenter(configuration: self.configuration)
    }
    
    /// Setup parameters for SDK. This is mandatory before accessing MoviesSDK.shared
    /// - Parameter appid: Your unique MoviesDatabase API key
    public func setup(appid: String){
        let configuration = ApiConfiguration(appid: appid)
        self.configuration = configuration
        self.presenter.updateConfiguration(configuration: configuration)
    }
    
}


