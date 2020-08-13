//
//  ViewController.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Tue 11 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController
{
    //MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    //MARK:- Properties
    
    private let cellIdentifier: String = "PersonCell"
    private let cellNibName: String = "PersonTableViewCell"
    let personDetailsVCIdentifier: String = "PersonDetailsViewController"
    
    var spinner = UIActivityIndicatorView()
    
    var viewModel: HomeViewModel!
    var currentPage: Int = 1
    var totalPages: Int = 1
    var isSearchActive: Bool = false
    var searchKey: String = ""
        
    var dataSource: TableViewDataSource<Person, PersonTableViewCell>!
    {
        didSet
        {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
    
    var persons: [Person] = []
    {
        didSet
        {
            self.dataSource = .make(for: self.persons)
        }
    }
    
    //MARK:- ViewController Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupViews()
        self.getPopularPersons()
    }

    //MARK:- Setup
    
    private func setupViews()
    {
        self.setupTableViewDataSource()
        self.setupTableView()
        self.setupViewModel()
        self.setupActivityIndicator()
        self.setupSearchTextField()
    }
    
    private func setupTableViewDataSource()
    {
        self.dataSource = .make(for: self.persons)
    }
    
    private func setupTableView()
    {
        self.tableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.delegate = self
    }
    
    private func setupSearchTextField()
    {
        self.searchTextField.delegate = self
        self.searchTextField.returnKeyType = .search
    }
    
    private func setupActivityIndicator()
    {
        self.spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        self.spinner.stopAnimating()
        self.spinner.hidesWhenStopped = true
        self.spinner.color = .systemBlue
        self.spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 60)
        self.tableView.tableFooterView = spinner
    }
    
    private func setupViewModel()
    {
        self.viewModel = HomeViewModel()
    }
    
    //MARK:- Methods
    
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
        self.persons.removeAll()
    }
    
    func prepareNavigationToDetails(at index: Int)
    {
        let personDetailsVC = self.storyboard!.instantiateViewController(withIdentifier: self.personDetailsVCIdentifier) as! PersonDetailsViewController
        personDetailsVC.person = self.persons[index]
        self.present(personDetailsVC, animated: true, completion: nil)
    }
    
    func prepareSearchAction()
    {
        if let key = self.searchTextField.text, !key.isEmpty
        {
            self.clearData()
            self.activateSearch()
            self.searchForPerson(with: key)
        }
        else
        {
            self.showAlert(title: "Search", message: "Please, enter person name!")
        }
    }
    
    func activateSearch()
    {
        self.isSearchActive = true
        self.view.endEditing(true)
        
        self.searchButton.tintColor = .systemRed
        self.searchButton.setImage(UIImage(systemName: "multiply"), for: .normal)
    }
    
    func deactivateSearch()
    {
        self.isSearchActive = false
        self.searchTextField.text = ""
        
        self.searchButton.tintColor = .systemBlue
        self.searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }
    
    //MARK:- Data Binding Methods
    
    func getPopularPersons()
    {
        self.viewModel.getPopularPersons(in: self.currentPage)
        {(persons, page, totalPages) in
            if let persons = persons
            {
                self.persons.append(contentsOf: persons)
                self.currentPage = page
                self.totalPages = totalPages
            }
            else
            {
                self.showAlert(title: "Popular Persons", message: "Cannot load more persons!")
            }
            
            self.stopLoading()
        }
    }
    
    func searchForPerson(with name: String)
    {        
        self.viewModel.searchForPerson(with: name, in: self.currentPage)
        {(persons, page, totalPages) in
            if let persons = persons
            {
                self.persons.append(contentsOf: persons)
                self.currentPage = page
                self.totalPages = totalPages
            }
            else
            {
                self.showAlert(title: "Search Result", message: "Cannot load more results!")
            }
            
            self.stopLoading()
        }
    }
    
    //MARK:- Actions
    
    func loadMore()
    {
        self.startLoading()
        
        if self.isSearchActive
        {
            self.loadMoreSearchResults()
        }
        else
        {
            self.loadMorePersons()
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton)
    {
        if self.isSearchActive
        {
            self.deactivateSearch()
            self.clearData()
            self.getPopularPersons()
        }
        else
        {
            self.prepareSearchAction()
        }
    }
}

// MARK:- ActivityIndicator -
extension HomeViewController
{
    func startLoading()
    {
        self.spinner.startAnimating()
    }
    
    func stopLoading()
    {
        self.spinner.stopAnimating()
    }
}
