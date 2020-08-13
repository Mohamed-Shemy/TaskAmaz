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
    //MARK: - Private Properties
    
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var searchKey: String = ""
    
    //MARK: - Observer Properties
    
    private var persons: [Person] = []
    {
        didSet
        {
            self.dataSource = .make(for: self.persons)
        }
    }
    
    var errorMessage: String?
    {
        didSet
        {
            self.displayErrorClosure?()
        }
    }
    
    var dataSource: TableViewDataSource<Person, PersonTableViewCell> = .make(for: [])
    {
        didSet
        {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false
    {
        didSet
        {
            isLoading ? startLoadingClosure?() : stopLoadingClosure?()
        }
    }
    
    // MARK: - Closures
    
    var reloadTableViewClosure: (()->())?
    var startLoadingClosure: (()->())?
    var stopLoadingClosure: (()->())?
    var displayErrorClosure: (()->())?
    
    // MARK: - API Call
    
    func getPopularPersons()
    {
        self.isLoading = true
        
        self.networkManager.getPopularPersons(in: self.currentPage)
        { (response) in
            
            switch response
            {
                case let .success(personsPresponse):
                    if let persons = personsPresponse.results, let page = personsPresponse.page, let totalPages = personsPresponse.totalPages
                    {
                        self.setData(persons, page, totalPages)
                    }
                    else
                    {
                        self.errorMessage = "Cannot load more persons!"
                    }
                case .failure(_):
                    self.errorMessage = "Cannot load more persons!"
            }
            
            self.isLoading = false
        }
    }
    
    func searchForPerson(with name: String)
    {
        self.isLoading = true
        self.searchKey = name
        
        self.networkManager.searchForPerson(with: name, in: self.currentPage)
        { (response) in
            
            switch response
            {
                case let .success(personsPresponse):
                    if let persons = personsPresponse.results, let page = personsPresponse.page, let totalPages = personsPresponse.totalPages
                    {
                        self.setData(persons, page, totalPages)
                    }
                    else
                    {
                        self.errorMessage = "Cannot load more results!"
                    }
                case .failure(_):
                    self.errorMessage = "Cannot load more results!"
            }
            
            self.isLoading = false
        }
    }
    
    // MARK:- Public Methods
    
    func loadMorePersons()
    {
        self.currentPage = min((self.currentPage + 1), self.totalPages)
        self.getPopularPersons()
    }
    
    func loadMoreSearchResults()
    {
        self.currentPage = min((self.currentPage + 1), self.totalPages)
        self.searchForPerson(with: self.searchKey)
    }
    
    func clearData()
    {
        self.currentPage = 1
        self.totalPages = 1
        self.searchKey = ""
        self.persons.removeAll()
    }
    
    func person(at index: Int) -> Person
    {
        return self.persons[index]
    }
    
    // MARK: - Private Methods
    
    private func setData(_ persons: [Person], _ currentPage: Int, _ totalPages: Int)
    {
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.persons.append(contentsOf: persons)
    }
}
