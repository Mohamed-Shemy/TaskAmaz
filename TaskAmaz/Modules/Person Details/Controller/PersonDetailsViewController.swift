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
    
    var profiles: [Profile] = []
    {
        didSet
        {
            self.imagesCollectionView.reloadData()
        }
    }
    
    //MARK:- ViewController Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupViews()
        
        self.getImages()
    }
    
    //MARK:- Setup
    
    private func setupViews()
    {
        self.setupTableView()
        self.setupCollectionView()
        self.setupViewModel()
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
    
    func prepareNavigationToDetails(at index: Int)
    {
        let originalImageVC = self.storyboard!.instantiateViewController(withIdentifier: self.originalImageVCIdentifier) as! OriginalImageViewController
        
        let cell = imagesCollectionView.cellForItem(at: IndexPath(row: index, section: 0)) as! PersonImageCollectionViewCell
        originalImageVC.profileImage = cell.profileImageView.image
        originalImageVC.profileImagePath = self.profiles[index].filePath
        
        self.present(originalImageVC, animated: true, completion: nil)
    }
    
    //MARK:- Data Binding Methods
    
    func getImages()
    {
        guard let id = person.id else { return }
        self.viewModel.getProfile(with: id)
        { profiles in
            
            if let profiles = profiles
            {
                self.profiles = profiles
            }
            else
            {
                self.showAlert(title: "Profiles", message: "Cannot load profiles!")
            }
        }
    }
    
    //MARK:- Actions
}
