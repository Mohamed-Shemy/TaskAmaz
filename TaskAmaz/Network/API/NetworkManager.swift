//
//  NetworkManager.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Tue 11 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Moya

extension NetworkManagerInjected
{
    var networkManager: Networkable
    {
        get
        {
            return NetworkManager()
        }
    }
}

class NetworkManager: Networkable
{
    // MARK: Properties
    
    private let provider: MoyaProvider<API>
    
    // MARK: Initiallization
    
    init(provider: MoyaProvider<API> = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()]))
    {
        self.provider = provider
    }
    
    // MARK: Methods
    
    func getPopularPersons(in page: Int = 1, completion: @escaping (Result<PageResponse<[Person]>, Error>) -> Void)
    {
        self.provider.request(.getPopularPersons(page: page))
        { result in
            
            switch result
            {
                case .success(let value):
                    let decoder = JSONDecoder()
                    do
                    {
                        let response = try decoder.decode(PageResponse<[Person]>.self, from: value.data)
                        completion(.success(response))
                    }
                    catch let error
                    {
                        completion(.failure(error))
                }
                
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func searchForPerson(with name: String, in page: Int = 1, completion: @escaping (Result<PageResponse<[Person]>, Error>) -> Void)
    {
        self.provider.request(.searchForPerson(name: name, page: page))
        { result in
            
            switch result
            {
                case .success(let value):
                    let decoder = JSONDecoder()
                    do
                    {
                        let response = try decoder.decode(PageResponse<[Person]>.self, from: value.data)
                        completion(.success(response))
                    }
                    catch let error
                    {
                        completion(.failure(error))
                }
                
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
