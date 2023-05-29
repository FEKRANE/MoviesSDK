//
//  UpcomingReleasesRQ.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation

struct UpcomingReleasesRQ: Encodable {
    let titleType: String?
    let page: String
    let limit: Int

    private enum CodingKeys: String, CodingKey {
        case titleType, page, limit
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(limit, forKey: .limit)
        try container.encode(page, forKey: .page)
        
        if let titleType {
            try container.encode(titleType, forKey: .titleType)
        }
    }
}
