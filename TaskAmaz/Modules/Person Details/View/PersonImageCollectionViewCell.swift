//
//  PersonImageCollectionViewCell.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Wed 12 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

class PersonImageCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var profileImageView: UIImageView!
    
    func configure(with imagePath: String?)
    {
        self.profileImageView.setImage(from: imagePath)
    }
}
