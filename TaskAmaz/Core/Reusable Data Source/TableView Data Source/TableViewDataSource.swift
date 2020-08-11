//
//  TableViewDataSource.swift
//  TestReusableDataSources
//
//  Created by Mohamed Shemy on Sun 2 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

class TableViewDataSource<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource
{
    typealias CellConfigurator = (Model, Cell, IndexPath) -> Void
    
    private let cellConfigurator: CellConfigurator
    //private var delegate: ConfigurableCell
    private let reuseIdentifier: String
    
    var models: [Model]
    
    init(models: [Model], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator)
    {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Cell
        
        self.cellConfigurator(model, cell, indexPath)
        
        return cell
    }
}
