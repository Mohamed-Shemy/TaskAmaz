//
//  PageResponse.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Tue 11 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

struct PageResponse<Model: Codable>: Codable
{
    let results : Model?
    let totalItems: Int?
    let totalPages: Int?
    let page: Int?
    
    enum CodingKeys: String, CodingKey
    {
        case results = "results"
        case totalItems = "total_results"
        case totalPages = "total_pages"
        case page = "page"
    }
}
