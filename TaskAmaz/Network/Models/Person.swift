//
//  Person.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Tue 11 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

struct Person: Codable
{
    let name: String?
    let id: Int?
    let popularity: Double?
    let department: String?
    let profilePath: String?
    let adult: Bool?
    let gender: Int?
    let media: [Media]
    
    enum CodingKeys: String, CodingKey
    {
        case name = "name"
        case id = "id"
        case popularity = "popularity"
        case department = "known_for_department"
        case profilePath = "profile_path"
        case adult = "adult"
        case gender = "gender"
        case media = "known_for"
    }
}
