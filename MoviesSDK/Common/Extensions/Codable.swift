//
//  Codable.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation

import Foundation

extension Encodable {
    var dictionary: [String: String]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let dict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else {return nil}
        return dict.compactMapValues { String(describing: $0) }
    }
}
