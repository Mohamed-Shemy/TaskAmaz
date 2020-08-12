//
//  ProfileResponse.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Wed 12 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

struct ProfileResponse: Codable
{
    let id: Int?
    let profiles: [Profile]?
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case profiles = "profiles"
    }
}
