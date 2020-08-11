//
//  UIImageView.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Tue 11 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView
{
    func setImage(from path: String?, placeholderImage: UIImage = UIImage(systemName: "person.fill")!)
    {
        if let path = path
        {
            let thePath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? path
            guard let url = URL(string: thePath) else { return }
            self.sd_setImage(with: url, placeholderImage: placeholderImage)
        }
    }
}
