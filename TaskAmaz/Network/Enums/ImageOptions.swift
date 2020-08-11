//
//  ImageOptions.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Wed 12 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

enum ImageOptions
{
    case original
    case width(_ width: Int)
    
    var value: String
    {
        switch self
        {
            case .original:
                return "original"
            case let .width(width):
                return "w\(width)"
        }
    }
}
