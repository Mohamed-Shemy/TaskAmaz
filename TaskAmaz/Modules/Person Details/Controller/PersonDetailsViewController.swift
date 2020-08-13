//
//  PersonDetailsViewController.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Wed 12 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

class PersonDetailsViewController: UIViewController
{
    //MARK:- Outlets
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    //MARK:- Properties
    
    let personDetailsCellIdentifier: String = "PersonDataCell"
    let imageCellIdentifier: String = "PersonImageCell"
    let originalImageVCIdentifier: String = "OriginalImageViewController"
    let numberOfCells: Int = 5
    
    var viewModel: PersonDetailsViewModel!
    
    var person: Person!
    
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
        self.setupCollectionView()
        self.setupViewModel()
        self.setupObservers()
        
        self.getImages()
    }
    
    private func setupTableView()
    {
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
        self.detailsTableView.tableFooterView = UIView()
    }
    
    private func setupCollectionView()
    {
        self.imagesCollectionView.delegate = self
        self.imagesCollectionView.dataSource = self
    }
    
    private func setupViewModel()
    {
        self.viewModel = PersonDetailsViewModel()
    }
    
    //MARK:- Methods
    
    func getImages()
    {
        if let id = self.person.id
        {
            self.viewModel.getProfile(with: id)
        }
        else
        {
            self.showAlert(title: "Error", message: "Cannot load profile")
        }
    }
    
    func prepareNavigationToDetails(at index: Int)
    {
        let originalImageVC = self.storyboard!.instantiateViewController(withIdentifier: self.originalImageVCIdentifier) as! OriginalImageViewController
        
        let cell = imagesCollectionView.cellForItem(at: IndexPath(row: index, section: 0)) as! PersonImageCollectionViewCell
        originalImageVC.profileImage = cell.profileImageView.image
        originalImageVC.profileImagePath = self.viewModel.profile(at: index).filePath
        
        self.present(originalImageVC, animated: true, completion: nil)
    }
    
    //MARK:- Data Binding Methods
    
    func setupObservers()
    {
        self.reloadCollectionViewObserver()
        self.displayErrorObserver()
    }
    
    func reloadCollectionViewObserver()
    {
        self.viewModel.reloadCollectionViewClosure =
            { [weak self] () in
                DispatchQueue.main.async
                    {
                        self?.imagesCollectionView.reloadData()
                }
        }
    }
    
    func displayErrorObserver()
    {
        self.viewModel.displayErrorClosure =
            { [weak self] () in
                let errorMessage = self?.viewModel.errorMessage ?? "Unkown error"
                self?.showAlert(title: "Error", message: errorMessage)
        }
    }
}
