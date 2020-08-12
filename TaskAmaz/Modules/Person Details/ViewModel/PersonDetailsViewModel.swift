//
//  PersonDetailsViewModel.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Wed 12 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

class PersonDetailsViewModel: NetworkManagerInjected
{
    func getProfile(with id: Int, completion: @escaping ([Profile]?) -> Void)
    {
        self.networkManager.getPersonImages(with: id)
        { (response) in
            
            switch response
            {
                case let .success(profilePresponse):
                    if let profiles = profilePresponse.profiles
                    {
                        completion(profiles)
                    }
                    else
                    {
                        completion(nil)
                    }
                case .failure(_):
                    completion(nil)
            }
        }
    }
}
