//
//  HomeDataBindingExtension.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Thu 13 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

extension HomeViewController
{
    //MARK:- Data Binding Methods
    
    func setupObservers()
    {
        self.reloadTableViewOberver()
        self.startLoadingOberver()
        self.stopLoadingOberver()
        self.displayErrorOberver()
    }
    
    func reloadTableViewOberver()
    {
        self.viewModel.reloadTableViewClosure =
            { [weak self] () in
                DispatchQueue.main.async
                    {
                        self?.tableView.dataSource = self?.viewModel.dataSource
                        self?.tableView.reloadData()
                }
        }
    }
    
    func startLoadingOberver()
    {
        self.viewModel.startLoadingClosure =
            {[weak self] () in
                self?.startLoading()
        }
    }
    
    func stopLoadingOberver()
    {
        self.viewModel.startLoadingClosure =
            {[weak self] () in
                self?.stopLoading()
        }
    }
    
    func displayErrorOberver()
    {
        self.viewModel.displayErrorClosure =
            {[weak self] () in
                let errorMessage = self?.viewModel.errorMessage ?? "Unkown error"
                self?.showAlert(title: "Error", message: errorMessage)
        }
    }
}
