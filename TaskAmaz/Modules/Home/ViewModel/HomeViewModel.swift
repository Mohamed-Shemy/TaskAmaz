//
//  HomeViewModel.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Wed 12 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

class HomeViewModel: NetworkManagerInjected
{
    func getPopularPersons(in page: Int, completion: @escaping ([Person]?, Int, Int) -> Void)
    {
        self.networkManager.getPopularPersons(in: page)
        { (response) in
            
            switch response
            {
                case let .success(personsPresponse):
                    if let persons = personsPresponse.results, let page = personsPresponse.page, let totalPages = personsPresponse.totalPages
                    {
                        completion(persons, page, totalPages)
                    }
                    else
                    {
                        completion(nil, 0, 0)
                    }
                case .failure(_):
                    completion(nil, 0, 0)
            }
        }
    }
    
    func searchForPerson(with name: String, in page: Int, completion: @escaping ([Person]?, Int, Int) -> Void)
    {
        self.networkManager.searchForPerson(with: name, in: page)
        { (response) in
            
            switch response
            {
                case let .success(personsPresponse):
                    if let persons = personsPresponse.results, let page = personsPresponse.page, let totalPages = personsPresponse.totalPages
                    {
                        completion(persons, page, totalPages)
                    }
                    else
                    {
                        completion(nil, 0, 0)
                }
                case .failure(_):
                    completion(nil, 0, 0)
            }
        }
    }
}
