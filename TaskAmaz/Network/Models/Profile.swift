//
//  Profile.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Wed 12 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

struct Profile: Codable
{
    let iso6391: String?
    let width: Int?
    let height: Int?
    let voteCount: Int?
    let voteAverage: Double?
    let aspectRatio: Double?
    let filePath: String?
    
    enum CodingKeys: String, CodingKey
    {
        case iso6391 = "iso_639_1"
        case width = "width"
        case height = "height"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
    }
}
