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
    //MARK: - Observer Properties
    
    var profiles: [Profile] = []
    {
        didSet
        {
            self.reloadCollectionViewClosure?()
        }
    }
    
    var errorMessage: String?
    {
        didSet
        {
            self.displayErrorClosure?()
        }
    }
    
    var numberOfItems: Int
    {
        return self.profiles.count
    }
    
    // MARK: - Closures
    
    var reloadCollectionViewClosure: (()->())?
    var displayErrorClosure: (()->())?
    
     // MARK: - API Call
    
    func getProfile(with id: Int)
    {
        self.networkManager.getPersonImages(with: id)
        { (response) in
            
            switch response
            {
                case let .success(profilePresponse):
                    if let profiles = profilePresponse.profiles
                    {
                        self.profiles = profiles
                    }
                    else
                    {
                        self.errorMessage = "Cannot load profile!"
                    }
                case .failure(_):
                    self.errorMessage = "Cannot load profile!"
            }
        }
    }
    
    // MARK:- Public Methods
    
    func profile(at index: Int) -> Profile
    {
        return self.profiles[index]
    }
}
