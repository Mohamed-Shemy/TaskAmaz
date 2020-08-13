//
//  OriginalImageViewController.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Wed 12 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

class OriginalImageViewController: UIViewController
{
    //MARK:- Outlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var toolBarView: UIView!
    
    //MARK:- Properties
    
    var viewModel: OriginalImageViewModel!
    
    var profileImage: UIImage?
    var profileImagePath: String? = ""
    var isToolViewHiddin: Bool = false
    
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
        self.setupImageView()
        self.setupViewModel()
        self.setupDisplayMessageObserver()
        
        self.getOriginalImage()
    }
    
    private func setupImageView()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.toggleToolsViewVisibility(_:)))
        self.profileImageView.addGestureRecognizer(tap)
        self.profileImageView.isUserInteractionEnabled = true
        
        // Set image
        self.profileImageView.image = self.profileImage
    }
    
    private func setupViewModel()
    {
        self.viewModel = OriginalImageViewModel()
    }
    
    //MARK:- Methods
    
    func getOriginalImage()
    {
        if let filePath = self.profileImagePath
        {
            let path = Helper.instance.getImageFullURL(with: filePath, option: .original)
            self.profileImageView.setImage(from: path, placeholderImage: self.profileImage ?? UIImage())
        }
    }
    
    func showToolView()
    {
        self.toolBarView.isHidden = false
    }
    
    func hideToolView()
    {
        self.toolBarView.isHidden = true
    }
    
    func saveImage(imageName: String, image: UIImage)
    {
        guard let data = image.jpegData(compressionQuality: 1)
        else
        {
            self.showAlert(title: "", message: "Incorrect data format!")
            return
        }
        
        self.viewModel.saveImage(with: imageName, data: data)
    }
    
    //MARK: - Observer
    
    func setupDisplayMessageObserver()
    {
        self.viewModel.displayErrorClosure =
        {[weak self] () in
                let errorMessage = self?.viewModel.message ?? "Unkown error"
                self?.showAlert(title: "Error", message: errorMessage)
        }
    }
    
    //MARK:- Actions
    
    @objc func toggleToolsViewVisibility(_ sender: UITapGestureRecognizer)
    {
        self.isToolViewHiddin ? self.showToolView() : self.hideToolView()
        self.isToolViewHiddin = !self.isToolViewHiddin
    }
    
    @IBAction func saveAction(_ sender: UIButton)
    {
        if let image = self.profileImageView.image, let filePath = self.profileImagePath
        {
            let fileName = String(filePath.suffix(filePath.count - 1))
            self.saveImage(imageName: fileName, image: image)
        }
    }
}
