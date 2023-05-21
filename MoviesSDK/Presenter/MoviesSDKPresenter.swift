//
//  MoviesSDKPresenter.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//
class MoviesSDKPresenter{
    
    fileprivate var interactor: InteractorProtocol
    fileprivate var configuration: ApiConfiguration?
    
    init(interactor: InteractorProtocol = MoviesSDKInteractor(), configuration: ApiConfiguration?) {
        self.interactor = interactor
        self.configuration = configuration
    }
    
    func updateConfiguration(configuration: ApiConfiguration){
        self.configuration = configuration
    }
}

