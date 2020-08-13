//
//  PersonDetailsCollectionViewExtension.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Wed 12 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

extension PersonDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        self.viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.imageCellIdentifier, for: indexPath) as! PersonImageCollectionViewCell
        
        let filePath = self.viewModel.profile(at: indexPath.row).filePath ?? ""
        let path = Helper.instance.getImageFullURL(with: filePath, option: .width(200))
        cell.configure(with: path)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.prepareNavigationToDetails(at: indexPath.row)
    }
}
