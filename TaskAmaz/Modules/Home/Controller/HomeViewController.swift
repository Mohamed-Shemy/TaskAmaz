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
    var moreButton: iButton!
    
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
        self.setupTableViewFooter()
        self.setupActivityIndicator()
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
    
    private func setupTableViewFooter()
    {
        let width = self.view.bounds.width - 50
        let customView = UIView(frame: CGRect(x: 25, y: 0, width: width, height: 100))
        self.moreButton = iButton(frame: CGRect(x: 0, y: 25, width: width, height: 50))
        self.moreButton.setTitle("More", for: .normal)
        self.moreButton.backgroundColor = .systemBlue
        self.moreButton.addTarget(self, action: #selector(loadMoreAction), for: .touchUpInside)
        self.moreButton.cornerRadius = 25.0
        self.moreButton.shadowRadius = 5.0
        self.moreButton.shadowOffsetWidth = 1.0
        self.moreButton.shadowOffsetHeight = 2.0
        self.moreButton.shadowOpacity = 0.8
        
        customView.addSubview(self.moreButton)
        self.tableView.tableFooterView = customView
    }
    
    private func setupActivityIndicator()
    {
        self.spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.spinner.stopAnimating()
        self.spinner.color = .white
        self.spinner.hidesWhenStopped = true
        self.spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 50, height: 50)
        self.moreButton.addSubview(self.spinner)
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
                
            }
            
            self.stopLoading()
        }
    }
    
    //MARK:- Actions
    
    @objc func loadMoreAction(_ sender: UIButton)
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
}

// MARK:- ActivityIndicator -
extension HomeViewController
{
    func startLoading()
    {
        self.spinner.startAnimating()
        self.moreButton.setTitle("", for: .normal)
        self.moreButton.isUserInteractionEnabled = false
    }
    
    func stopLoading()
    {
        self.moreButton.setTitle("More", for: .normal)
        self.moreButton.isUserInteractionEnabled = true
        self.spinner.stopAnimating()
    }
}
