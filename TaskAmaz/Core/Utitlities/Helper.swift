//
//  Helper.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Wed 12 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

class Helper
{
    public static let instance: Helper = Helper()
    private init(){}
    
    func getImageFullURL(with path: String, option: ImageOptions) -> String
    {
        return "\(URLs.image.rawValue)/\(option.value)\(path)"
    }
}
