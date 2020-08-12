//
//  API.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Tue 11 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Moya

enum URLs: String
{
    case base = "https://api.themoviedb.org/3/"
    case image = "https://image.tmdb.org/t/p/"
}

enum API
{
    case getPopularPersons(page: Int)
    case searchForPerson(name: String, page: Int)
    case getPersonImages(id: Int)
}

extension API: TargetType
{
    var API_KEY: String
    {
        return "8bfe5f7cdf5a7473394685c92399f030"
    }
    
    var baseURL: URL
    {
        let base = URLs.base.rawValue
        guard let url = URL(string: base) else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String
    {
        switch self
        {
            case .getPopularPersons:
                return "person/popular"
            
            case .searchForPerson:
                return "search/person"
            
            case let .getPersonImages(id):
                return "person/\(id)/images"
        }
    }
    
    var method: Moya.Method
    {
        return .get
    }
    
    var sampleData: Data
    {
        return Data()
    }
    
    var headers: [String : String]?
    {
        return [:]
    }
    
    var task: Task
    {
        switch self
        {
            case let .getPopularPersons(page):
                var parameters: [String: Any] = ["api_key": API_KEY]
                parameters["page"] = page
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
            case let .searchForPerson(name, page):
                var parameters: [String: Any] = ["api_key": API_KEY]
                parameters["query"] = name
                parameters["page"] = page
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
            default:
                let parameters: [String: Any] = ["api_key": API_KEY]
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
