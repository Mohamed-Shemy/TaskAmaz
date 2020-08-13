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
    
    func saveImage(imageName: String, image: UIImage) -> (Bool, String?)
    {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            else { return (false, "Cannot locate directory!") }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1)
            else { return (false, "Incorrect data format!") }
        
        if FileManager.default.fileExists(atPath: fileURL.path)
        {
            do
            {
                try FileManager.default.removeItem(atPath: fileURL.path)
            }
            catch let removeError
            {
                return (false, removeError.localizedDescription)
            }
        }
        do
        {
            try data.write(to: fileURL)
            return (true, nil)
        }
        catch let error
        {
            return (false, error.localizedDescription)
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
            let (isSaved, msg) = self.saveImage(imageName: fileName, image: image)
            if isSaved
            {
                self.showAlert(title: "Save", message: "Image has been saved")
            }
            else
            {
                self.showAlert(title: "Error", message: msg ?? "Cannot save this image!")
            }
        }
    }
}
