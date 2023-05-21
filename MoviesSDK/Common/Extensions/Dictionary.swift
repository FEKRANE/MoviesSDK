//
//  Dictionary.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation

extension Dictionary {
    func dictionaryQueryString()-> String {
        let urlParams:String = self.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&");
        
        return urlParams;
    }
}
