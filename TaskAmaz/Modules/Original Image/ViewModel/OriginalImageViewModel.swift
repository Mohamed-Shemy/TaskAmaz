//
//  OriginalImageViewModel.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Thu 13 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import Foundation

class OriginalImageViewModel
{
    var message: String?
    {
        didSet
        {
            self.displayErrorClosure?()
        }
    }
    
    var displayErrorClosure: (()->())?
    
    func saveImage(with fileName: String, data: Data)
    {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            else
        {
            self.message = "Cannot locate directory!"
            return
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path)
        {
            do
            {
                try FileManager.default.removeItem(atPath: fileURL.path)
            }
            catch let removeError
            {
                self.message = removeError.localizedDescription
            }
        }
        do
        {
            try data.write(to: fileURL)
            self.message = "Image has been saved"
        }
        catch let error
        {
            self.message = error.localizedDescription
        }
    }
}
