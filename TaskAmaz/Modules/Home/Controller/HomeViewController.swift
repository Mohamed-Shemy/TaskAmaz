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
    var isSearchActive: Bool = false
    var searchKey: String = ""
  
    
    //MARK:- ViewController Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupViews()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    //MARK:- Setup
    
    private func setupViews()
    {
        self.setupTableView()
        self.setupViewModel()
        self.setupActivityIndicator()
        self.setupSearchTextField()
        self.setupObservers()
        
         self.viewModel.getPopularPersons()
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
        self.viewModel.loadMorePersons()
    }
    
    func loadMoreSearchResults()
    {
        self.viewModel.loadMoreSearchResults()
    }
    
    func prepareNavigationToDetails(at index: Int)
    {
        let personDetailsVC = self.storyboard!.instantiateViewController(withIdentifier: self.personDetailsVCIdentifier) as! PersonDetailsViewController
        personDetailsVC.person = self.viewModel.person(at: index)
        self.present(personDetailsVC, animated: true, completion: nil)
    }
    
    func prepareSearchAction()
    {
        if let key = self.searchTextField.text, !key.isEmpty
        {
            self.viewModel.clearData()
            self.activateSearch()
            self.viewModel.searchForPerson(with: key)
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
   
    //MARK:- Actions
    
    func loadMore()
    {
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
            self.viewModel.clearData()
            self.viewModel.getPopularPersons()
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
