//
//  Media.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Tue 11 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

struct Media: Codable
{
    let name: String?
    let id: Int?
    let originalName: String?
    let genreIds: [Int]?
    let mediaType: String?
    let voteCount: Int?
    let firstAirDate: String?
    let backdropPath: String?
    let originalLanguage: String
    let voteAverage: Double?
    let overview: String?
    let posterPath: String?
    let originCountry: [String]?
    let video: Bool?
    let adult: Bool?
    let releaseDate: String?
        
    enum CodingKeys: String, CodingKey
    {
        case name = "name"
        case id = "id"
        case originalName = "original_name"
        case genreIds = "genre_ids"
        case mediaType = "media_type"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
        case overview = "overview"
        case posterPath = "poster_path"
        case originCountry = "origin_country"
        case video = "video"
        case adult = "adult"
        case releaseDate = "release_date"
    }
}
