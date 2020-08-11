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
    
}

// MARK:- TableViewDataSource -
extension TableViewDataSource where Model == Person, Cell == PersonTableViewCell
{
    static func make(for persons: [Person], reuseIdentifier: String = "PersonCell") -> TableViewDataSource
    {
        return TableViewDataSource(models: persons, reuseIdentifier: reuseIdentifier)
        {person, cell, indexPath in
            
            
            cell.profileImageView.setImage(from: person.profilePath)
            cell.nameLabel.text = person.name
            cell.popularityLabel.text = "\(person.popularity ?? 0.0)/100.0"
        }
    }
}
