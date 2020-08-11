//
//  ConfigurableCell.swift
//  TestReusableDataSources
//
//  Created by Mohamed Shemy on Sun 2 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

protocol ConfigurableCell: class
{
    func configur<Model, Cell>(_ model: Model, _ cell: Cell, _ indexPath: IndexPath)
}
