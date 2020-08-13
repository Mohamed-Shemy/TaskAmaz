//
//  HomeViewControllerExtension.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Tue 11 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate -
extension HomeViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        self.prepareNavigationToDetails(at: indexPath.row)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        
        if y > h
        {
            self.loadMore()
        }
    }
}

// MARK: - UITextFieldDelegate -
extension HomeViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        self.prepareSearchAction()
        
        return true
    }
}

// MARK:- TableViewDataSource -
extension TableViewDataSource where Model == Person, Cell == PersonTableViewCell
{
    static func make(for persons: [Person], reuseIdentifier: String = "PersonCell") -> TableViewDataSource
    {
        return TableViewDataSource(models: persons, reuseIdentifier: reuseIdentifier)
        {person, cell, indexPath in
            
            if let profilePath = person.profilePath
            {
                let path = Helper.instance.getImageFullURL(with: profilePath, option: .width(200))
                cell.profileImageView.setImage(from: path)
            }
            
            cell.nameLabel.text = person.name
            cell.popularityLabel.text = "\(person.popularity ?? 0.0)"
        }
    }
}
