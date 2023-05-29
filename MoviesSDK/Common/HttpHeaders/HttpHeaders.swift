//
//  HttpHeaders.swift
//  MoviesSDK
//
//  Created by FEKRANE on 29/5/2023.
//

import Foundation

struct HttpHeaders {
    
    let appID: String
    
    var dictionary : [String: String] {
        [
            "X-RapidAPI-Key"  : "\(appID)",
            "X-RapidAPI-Host" : "moviesdatabase.p.rapidapi.com",
            "Content-Type"    : "application/json"
         ]
    }
    
}
