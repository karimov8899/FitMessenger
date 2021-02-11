//
//  ImageAssets.swift
//  Messanger
//
//  Created by Dave on 2/2/21.
//

import UIKit

enum ImageAssets: String {
    
    case chatIcon
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
    var color: UIColor?{
        return UIColor(named: self.rawValue)
    }
    
}
