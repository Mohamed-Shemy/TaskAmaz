//
//  PersonDetailsTableViewExtension.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Wed 12 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

extension PersonDetailsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.person == nil { return 0 }
        
        return self.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.personDetailsCellIdentifier, for: indexPath)
        
        switch indexPath.row
        {
            case 0:
                cell.textLabel?.text = "Name"
                cell.detailTextLabel?.text = self.person.name
                cell.imageView?.image = UIImage(systemName: "person.fill")
            
            case 1:
                cell.textLabel?.text = "Popularity"
                cell.detailTextLabel?.text = "\(self.person.popularity ?? 0.0)"
                cell.imageView?.tintColor = .systemYellow
                cell.imageView?.image = UIImage(systemName: "star.fill")
            
            case 2:
                cell.textLabel?.text = "Department"
                cell.detailTextLabel?.text = self.person.department
                cell.imageView?.image = UIImage(systemName: "briefcase")
            
            case 3:
                cell.textLabel?.text = "Gender"
                cell.detailTextLabel?.text = (self.person.gender ?? 2) == 1 ? "Female" : "Male"
                cell.imageView?.image = UIImage(systemName: "person")
            
            case 4:
                cell.textLabel?.text = "Adult"
                cell.detailTextLabel?.text = (self.person.adult ?? true) ? "Yes" : "No"
                cell.imageView?.tintColor = .systemRed
                cell.imageView?.image = UIImage(systemName: "person")
            
            default:
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
}
