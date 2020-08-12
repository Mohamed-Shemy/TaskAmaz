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
    
    var spinner = UIActivityIndicatorView()
    var moreButton: iButton!
    
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
        self.moreButton = iButton(frame: CGRect(x: 0, y: 20, width: width, height: 50))
        self.moreButton.setTitle("More", for: .normal)
        self.moreButton.backgroundColor = .systemBlue
        self.moreButton.addTarget(self, action: #selector(loadMoreAction), for: .touchUpInside)
        self.moreButton.cornerRadius = 25.0
        self.moreButton.shadowRadius = 5.0
        self.moreButton.shadowOffsetWidth = 1.0
        self.moreButton.shadowOffsetHeight = 2.0
        self.moreButton.shadowOpacity = 0.5
        customView.addSubview(self.moreButton)
        
        self.setupActivityIndicator()
        self.tableView.tableFooterView = customView
    }
    
    private func setupActivityIndicator()
    {
        self.spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.spinner.stopAnimating()
        self.spinner.color = .black
        self.spinner.hidesWhenStopped = true
        self.spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50)
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
    
    //MARK:- Actions
    
    @objc func loadMoreAction(_ sender: UIButton)
    {
        self.startLoading()
        
        self.loadMorePersons()
    }
}

// MARK:- ActivityIndicator -
extension HomeViewController
{
    func startLoading()
    {
        self.moreButton.setTitle("", for: .normal)
        self.moreButton.isUserInteractionEnabled = false
        self.spinner.startAnimating()
    }
    
    func stopLoading()
    {
        self.spinner.stopAnimating()
        self.moreButton.setTitle("More", for: .normal)
        self.moreButton.isUserInteractionEnabled = true
    }
}
