//
//  UpcomingReleasesRS.swift
//  MoviesSDK
//
//  Created by FEKRANE on 21/5/2023.
//

import Foundation


import Foundation

struct UpcomingReleasesRS: Decodable {
    let resultsTotal: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case resultsTotal = "entries"
        case movies = "results"
    }
}

struct Movie: Decodable {
    let title: MovieTitle
    let image: MovieImage?
    let releaseDate: ReleaseDate
    
    enum CodingKeys: String, CodingKey {
        case title = "titleText"
        case image = "primaryImage"
        case releaseDate
    }
}

struct MovieImage: Decodable {
    let width: Int
    let height: Int
    let url: String
}

struct MovieTitle: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "text"
    }
}

struct ReleaseDate: Decodable {
    let day: Int
    let month: Int
    let year: Int
}
