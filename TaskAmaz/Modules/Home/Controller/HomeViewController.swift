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
    
    var viewModel: HomeViewModel!
    var currentPage: Int = 1
    var totalPages: Int = 1
    
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
    
    private func setupViewModel()
    {
        self.viewModel = HomeViewModel()
    }
    
    //MARK:- Methods
    
    func getPopularPersons()
    {
        self.viewModel.getPopularPersons(in: self.currentPage)
        {(persons, page, totalPages) in
            if let persons = persons
            {
                self.persons = persons
                self.currentPage = page
                self.totalPages = totalPages
            }
            else
            {
                
            }
        }
    }
    
    //MARK:- Actions
}

