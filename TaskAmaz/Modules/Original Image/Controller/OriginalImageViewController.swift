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
    
    var profileImage: UIImage?
    var profileImagePath: String? = ""
    var isToolViewHiddin: Bool = false
    
    //MARK:- ViewController Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupViews()
        
        self.getOriginalImage()
    }
    
    //MARK:- Setup
    
    private func setupViews()
    {
        self.setupImageView()
    }
    
    private func setupImageView()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.toggleToolsViewVisibility(_:)))
        self.profileImageView.addGestureRecognizer(tap)
        self.profileImageView.isUserInteractionEnabled = true
        
        // Set image
        self.profileImageView.image = self.profileImage
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
    
    func saveImage()
    {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = self.profileImagePath ?? "image"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = self.profileImageView.image?.jpegData(compressionQuality: 1) else { return }
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
            
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
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
        
    }
}
